// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// store num one and initialize counter
@R0
D=M
@numone
M=D
@counter
M=D

// store num two
@R1
D=M
@numtwo
M=D

// initialize sum
@sum
M=0

// setup loop
(LOOP)
  // end if loop has executed numone times
  @counter
  D=M
  @END
  D;JLE

  // add to sum
  @numtwo
  D=M
  @sum
  M=D+M

  // decrement counter
  @counter
  M=M-1
  @LOOP
  0;JMP

// end
(END)
	// store sum in r2
  @sum
  D=M
  @R2
  M=D
  // terminate w/ infinite loop
  0;JMP

