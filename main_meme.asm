; Main file for Lab
;
; Meme Team:
; 

segment .data
  menu         db "STATE DMV DRIVERS EXAMINATION",0xa,\
                  "-----------------------------",0xa,\
                  "1. Enter Applicant Data File Name",0xa,\
                  "2. Grade Applicant Examination",0xa,\
                  "3. Display Applicant Results",0xa,\
                  "4. Exit The Program",0xa,\
                  "-----------------------------",0xa,\
                  "Enter Option 1, 2, 3, or 4: ", 0x0
  input_string db "%c",0x0
  test_string db "You Entered: %c",0xa,0x0
  clear db "clear",0x0

segment .bss
  ans resb 1

segment .text

  global main
  extern system
  extern printf
  extern scanf
  extern exit

main:
  push rbp
  mov rbp, rsp
  
  lea rdi, [clear]
  call system

  lea rdi, [menu]
  call printf

  lea rdi, [input_string]
  mov rsi, ans
  call scanf


  lea rdi, [test_string]
  mov rsi, [ans]
  call printf

  xor rdi,rdi
  call exit

