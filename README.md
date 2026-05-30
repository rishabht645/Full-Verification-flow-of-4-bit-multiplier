# Full Verification Flow of 4-Bit Multiplier

## Overview

This project implements a complete SystemVerilog verification environment for a 4-bit multiplier. The verification flow is built using modular testbench components that generate stimulus, drive inputs to the DUT, monitor outputs, and automatically check correctness through a scoreboard.

---




## Testbench Components

<p align="center">

<img width="412" height="527" alt="Screenshot 2026-05-31 at 1 19 35 AM" src="https://github.com/user-attachments/assets/950abb8a-cbc9-4655-81ae-c0b7fe4a433b" />

</p>

### Transaction

* Defines the input stimulus structure
* Encapsulates multiplier operands and expected transaction data
* Serves as the communication object between verification components

### Generator

* Creates randomized transactions
* Produces test vectors for functional verification
* Sends transactions to the driver through a mailbox

### Driver

* Receives transactions from the generator
* Converts transaction-level data into pin-level DUT signals
* Applies stimulus to the multiplier inputs

### Monitor

* Observes DUT interface signals
* Captures input and output activity
* Packages observed data into transactions
* Sends collected information to the scoreboard

### Scoreboard

* Computes expected multiplication results
* Compares expected outputs with DUT outputs
* Reports pass and fail conditions
* Tracks overall verification correctness

### Mailbox Communication

* Enables synchronized communication between testbench components
* Transfers transaction objects without direct component dependencies
* Connects generator, driver, monitor, and scoreboard through message passing
* Helps create a modular and reusable verification architecture

### DUT (4-Bit Multiplier)

* Performs multiplication of two 4-bit operands
* Produces an 8-bit output result
* Acts as the design under verification

### Test Environment

* Instantiates and connects all verification components
* Controls simulation execution
* Coordinates communication between modules

---

## Verification Flow

* Generator creates randomized transactions
* Driver applies generated stimulus to the DUT
* DUT processes multiplication operation
* Monitor captures DUT inputs and outputs
* Scoreboard compares actual and expected results
* Verification status is reported

---

## Simulation Output

```text
 -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 30
# KERNEL: a : 0 	 b : 0 	 product : 0
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 30
# KERNEL: a : 0 	 b : 0 	 product : 0
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 70
# KERNEL: a : 2 	 b : 7 	 product : 14
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 70
# KERNEL: a : 2 	 b : 7 	 product : 14
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 110
# KERNEL: a : 14 	 b : 7 	 product : 98
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 110
# KERNEL: a : 14 	 b : 7 	 product : 98
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 150
# KERNEL: a : 7 	 b : 1 	 product : 7
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 150
# KERNEL: a : 7 	 b : 1 	 product : 7
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 190
# KERNEL: a : 14 	 b : 10 	 product : 140
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 190
# KERNEL: a : 14 	 b : 10 	 product : 140
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 230
# KERNEL: a : 15 	 b : 7 	 product : 105
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 230
# KERNEL: a : 15 	 b : 7 	 product : 105
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 270
# KERNEL: a : 5 	 b : 8 	 product : 40
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 270
# KERNEL: a : 5 	 b : 8 	 product : 40
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 310
# KERNEL: a : 1 	 b : 8 	 product : 8
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 310
# KERNEL: a : 1 	 b : 8 	 product : 8
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 350
# KERNEL: a : 10 	 b : 5 	 product : 50
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 350
# KERNEL: a : 10 	 b : 5 	 product : 50
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 390
# KERNEL: a : 2 	 b : 10 	 product : 20
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 390
# KERNEL: a : 2 	 b : 10 	 product : 20
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
# KERNEL: -------------------------------
# KERNEL: [MON] : DATA SENT TO SCOREBOARD at 430
# KERNEL: a : 14 	 b : 2 	 product : 28
# KERNEL: [SCO] : DATA RCVD FROM MONITOR at 430
# KERNEL: a : 14 	 b : 2 	 product : 28
# KERNEL: -------------------------------
# KERNEL: [SCO] : CORRECT RESULT
```

---

## Features

* Randomized stimulus generation
* Self-checking verification environment
* Modular testbench architecture
* Automated result comparison
* Scalable verification framework
* Mailbox-based component communication

---

##Tools used

* EDA playground
* iverilog

