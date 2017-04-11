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
  opt_1_ans db "opt 1",0x0
  opt_2_ans db "opt 2",0x0
  opt_3_ans db "opt 3",0x0
  opt_4_ans db "Good Bye",0xa,0x0
  invalid_opt_ans db "invalid option",0x0

segment .bss
  ans resb 1

segment .text

  global main
  extern system
  extern printf
  extern getchar
  extern fflush
  extern scanf
  extern exit

_clear_buff:
  push rbp
  mov rbp,rsp

  call getchar
  while:
    cmp rax, 0x0a
    jnz while

  mov rsp,rbp
  pop rbp
  ret




main:
  push rbp
  mov rbp, rsp
  
  _control_loop:
    ; int system(const char *command
    lea rdi, [clear]
    call system

    ; int printf(const char *format, ...)
    lea rdi, [menu]
    call printf

    ; int scanf(const char *format, ...)
    lea rdi, [input_string]
    mov rsi, ans
    call scanf

    opt_1:
      cmp [ans], byte '1'
      jnz opt_2
      lea rdi, [opt_1_ans]
      call printf
      call _clear_buff
      call getchar
      jmp _control_loop
    opt_2:
      cmp [ans], byte '2'
      jnz opt_3
      lea rdi, [opt_2_ans]
      call printf
      call _clear_buff
      call getchar
      jmp _control_loop
    opt_3:
      cmp [ans], byte '3'
      jnz opt_4
      lea rdi, [opt_3_ans]
      call printf
      call _clear_buff
      call getchar
      jmp _control_loop
    opt_4:
      cmp [ans], byte '4'
      jnz invalid_opt
      lea rdi, [opt_4_ans]
      call printf
      jmp _end_control
    invalid_opt:
      lea rdi, [invalid_opt_ans]
      call printf
      call _clear_buff
      call getchar
      jmp _control_loop
  _end_control:


  xor rdi,rdi
  call exit