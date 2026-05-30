////this code implements the -
//// 1. TRANSACTION CLASS
//// 2. GENERATOR BLOCK
//// 3. DRIVER BLOCK
interface mul_if();
  logic [3:0] a,b;
  logic clk;
  logic [7:0] mul;
endinterface

class transaction;
  rand bit [3:0] a,b;
  bit [7:0] mul;
  function transaction copy();
    copy = new();
    copy.a = this.a;
    copy.b = this.b;
    copy.mul = this.mul;
  endfunction
  
  function void display();
    $display("a : %0d \t b : %0d \t mul : %0d", a,b,mul);
  endfunction
  
endclass

class generator;
  transaction t;
  mailbox #(transaction) mbx;
  event done;
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    t = new();
  endfunction
  
  task run();
    for (int i = 0; i <10; i++) begin
      assert(t.randomize()) else begin 
        $display("RANDOMIZATION FAILED"); $finish;
      end
      $display("[GEN] : DATA SENT");
      t.display();
      mbx.put(t.copy);
      #20;
    end
    -> done;
  endtask
endclass

class driver;
  virtual mul_if mif;
  mailbox #(transaction) mbx;
  transaction td;
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  task run();
    td = new();
    forever begin
      mbx.get(td);
      @(posedge mif.clk);
      mif.a <= td.a;
      mif.b <= td.b;
      mif.mul <= td.mul;
      $display("[DRV] : DATA RCVD");
      td.display();
    end
  endtask
endclass

module tb;
  mul_if mif();
  event done;
  generator gen;
  driver drv;
  mailbox #(transaction) mbx;
  
  top dut(.a(mif.a), .b(mif.b), .clk(mif.clk), .mul(mif.mul));
  
  initial begin
    mif.clk = 0;
  end
  always #10 mif.clk = ~mif.clk;
  initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);
    drv.mif = mif;
    done = gen.done;
  end
  
  initial begin
    fork
      gen.run();
      drv.run();
    join_none
    wait(done.triggered);
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule


















