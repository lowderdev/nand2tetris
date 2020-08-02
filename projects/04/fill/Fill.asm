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

// pseudo code
// --------------------
// HOLDCLEAR
//   JUMP to HOLDCLEAR if @KBD == 0
//   *fill screen
//
// HOLDFILL
//   JUMP to HOLDFILL if @KBD > 0
//   *clear screen
//
//   JUMP to HOLDCLEAR

// note: screen size
// --------------------
// 8192, 16-bit "words"
// beginning at 16,384
//
//   16,384 // screen beginning
// +  8,192 // screen size
// --------
//   24,576 // last address of screen


// BEGIN PROGRAM
// --------------------
  @24576
  D=A
  @endscreen
  M=D         // set endscreen to correct address

(HOLDCLEAR)
  @KBD
  D=M
  @HOLDCLEAR
  D;JEQ       // jump to HOLDCLEAR if @KBD == 0

  @SCREEN     // begin fill screen
  D=A
  @addr
  M=D         // set addr to beginning of screen

(FILLLOOP)
  @endscreen
  D=M
  @addr
  D=D-M
  @HOLDFILL
  D;JLE       // jump to HOLDFILL if (@endscreen - @addr) <= 0

  @addr
  A=M
  M=-1        // set RAM[addr] to -1 (black)

  @addr
  M=M+1       // addr = addr + 1
  @FILLLOOP
  0;JMP       // jump to LOOP

(HOLDFILL)
  @KBD
  D=M
  @HOLDFILL
  D;JGT       // jump to HOLDFILL if @KBD > 0

  @SCREEN     // begin clear screen
  D=A
  @addr
  M=D         // set addr to beginning of screen

(CLEARLOOP)
  @endscreen
  D=M
  @addr
  D=D-M
  @HOLDCLEAR
  D;JLE       // jump to HOLDCLEAR if (@endscreen - @addr) <= 0

  @addr
  A=M
  M=0         // set RAM[addr] to 0 (white)

  @addr
  M=M+1       // addr = addr + 1
  @CLEARLOOP
  0;JMP       // jump to CLEARLOOP
