// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// This implementation does not handle negative arguments

// pseudo code
// --------------------
// m = RAM[0]
// n = RAM[1]
// R2 = 0 // result address used as acc
//
// LOOP
// JUMP to @END if n == 0
// sum = sum + m
// n = n - 1
//

  @R0
  D=M
  @m
  M=D // m = RAM[0]

  @R1
  D=M
  @n
  M=D // n = RAM[1]

  @R2
  M=0 // acc = 0

(LOOP)
  @n
  D=M
  @END
  D;JEQ

  @m
  D=M
  @R2
  M=M+D // acc = acc + m

  @n
  M=M-1 // n = n - 1

  @LOOP
  0;JMP // goto LOOP

(END)
  @END
  0;JMP
