////This segment implements the -
////1. TRANSACTION CLASS
////2. SCORBOARD
////3. MONITOR

class transaction;
  bit [3:0] a,b;
  bit [7:0] mul;
  function void display();
    $display("a : %0d \t b : %0d \t product : %0d", a,b,mul);
  endfunction
endclass

interface mul_if;
  logic [3:0] a,b;
  logic clk;
  logic [7:0] mul;
endinterface

class monitor;
  transaction t;
  virtual mul_if mif;
  mailbox #(transaction) mbx;
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    t = new();
  endfunction
  
  task run();
    forever begin
      repeat(2) @(posedge mif.clk);
      t.a = mif.a;
      t.b = mif.b;
      t.mul = mif.mul;
      $display("-------------------------------");
      $display("[MON] : DATA SENT TO SCOREBOARD at %0t", $time);
      t.display();
      mbx.put(t);
    end
  endtask
endclass

class scoreboard;
  transaction td;
  mailbox #(transaction) mbx;
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    td = new();
  endfunction
  
  task run();
    forever begin
      #30;
      mbx.get(td);
      $display("[SCO] : DATA RCVD FROM MONITOR at %0t", $time);
      td.display();
      $display("-------------------------------");
      if (td.mul == (td.a * td.b)) begin
        $display("[SCO] : CORRECT RESULT");
      end
      else begin
        $error("[SCO] : RESULT MISMATCH");
      end
    end
  endtask
endclass

module tb;
  mul_if mif();
  mailbox #(transaction) mbx;
  scoreboard sco;
  monitor mon;
  
  multiplier dut(.a(mif.a), .b(mif.b), .clk(mif.clk), .mul(mif.mul));
  
  initial begin
    mif.clk = 0;
  end
  always #10 mif.clk = ~mif.clk;
  
  initial begin
    mbx = new();
    sco = new(mbx);
    mon = new(mbx);
    mon.mif = mif;
  end
  
  initial begin
    for (int i = 0; i < 20; i ++) begin
      repeat(2) @(posedge mif.clk);
      mif.a <= $urandom_range(1,15);
      mif.b <= $urandom_range(1,10);
    end
  end
  
  initial begin
    fork 
      mon.run();
      sco.run();
    join_none
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #450;
    $finish();
  end
endmodule
