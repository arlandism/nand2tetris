// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

@8192
D=A
@num_cells
M=D
(LISTEN_FOR_INPUT)
  // grab from the keyboard memory mapped region to see if
  // anything is being pressed
  @KBD
  D=M

  // if register == 0, i.e. if user is not pressing anything
  @clear_counter
  M=0
  @NO_USER_INPUT
  D;JEQ

  @draw_counter
  M=0
  @DRAW_SCREEN
  0;JMP

(DRAW_SCREEN)
  @clear_counter
  M=0
  // see if we've drawn all the pixels
  @num_cells
  D=M
  @draw_counter
  D=D-M
  @LISTEN_FOR_INPUT
  D;JLE

  // get the screen + offset address and write all the pixels to it
  @draw_counter
  D=M
  @SCREEN
  A=D+A
  M=-1

  @draw_counter
  M=M+1

  @DRAW_SCREEN
  0;JMP

(NO_USER_INPUT)
  @draw_counter
  M=0
  // see if we've drawn all the pixels
  @num_cells
  D=M
  @clear_counter
  D=D-M
  @LISTEN_FOR_INPUT
  D;JLE

  // get the screen + offset address and write all the pixels to it
  @clear_counter
  D=M
  @SCREEN
  A=D+A
  M=0

  @clear_counter
  M=M+1
  @NO_USER_INPUT
  0;JMP

