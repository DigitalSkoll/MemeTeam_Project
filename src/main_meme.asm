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
  header      db  0xa,0xa,0xa,\
                  "Applicant %s",0xa,0xa,\
                  " DMV     Applicant",0xa,\
                  "-------------------",0xa,0xa,0xa,0
  cmp_fmt db      " %c       %c %c",0xa,0
  correct_count db 0
  total_count db 0
  pass db "PASS",0
  fail db "FAIL",0
  grade_fmt db    0xa,\
                  "Department of Motor Vehicles",0xa,\
                  "Driving Exam",0xa,\
                  "Applicant: %s",0xa,\
                  "Correct Answers: %d/%d",0xa,\
                  "Score: %s",0xa,0
  input_string db "%c",0x0
  test_string db "You Entered: %c",0xa,0x0
  clear db "clear",0x0
  opt_1_ans db "opt 1",0x0
  opt_2_ans db "opt 2",0x0
  opt_3_ans db "opt 3",0x0
  opt_4_ans db "Good Bye",0xa,0x0
  invalid_opt_ans db "invalid option",0x0
  file_input db "%s",0x0
  file_name times 30 db 0
  test_output db "%s",0xa,0x0
  file_mode db "r",0x0
  error db "[ERROR] File Not Found",0xa,0x0
  ans_file_name db "datafiles/Answers.txt",0


segment .bss
  ans resb 1
  file_ptr resq 1
  ans_file_ptr resq 1
  correct_char resb 1

segment .text

  global main
  extern system
  extern printf
  extern getchar
  extern scanf
  extern fopen
  extern fclose
  extern fgetc
  extern putchar
  extern exit

_opt1:
  push rbp
  mov rbp,rsp
  opt1_start:
  lea rdi, [file_input]
  mov rsi, file_name
  call scanf
  lea rdi, [file_name]
  lea rsi, [file_mode]
  call fopen
  mov [file_ptr], rax
  xor rax,rax
  cmp [file_ptr],rax 
  jnz opt1_end

  lea rdi, [error]
  call printf
  call _clear_buff
  jmp opt1_start

  opt1_end:

  leave
  ret

_opt2:
  push rbp
  mov rbp, rsp

  lea rdi, [header]
  lea rsi, [file_name]
  call printf

  lea rdi, [ans_file_name]
  lea rsi, [file_mode]
  call fopen
  mov [ans_file_ptr], rax
  cmp byte [ans_file_ptr], 0
  jnz opt2_next

  lea rdi, [error]
  call printf
  call_clear_buff
  jmp opt2_end
  opt2_next:

  mov r12, [ans_file_ptr]
  mov r13, [file_ptr]
  push r12
  push r13
  opt2_while:
    mov rdi, [ans_file_ptr]
    call fgetc
    cmp al, -1
    jz end_opt2_while

    mov [ans], al
    mov rdi, [file_ptr]
    call fgetc
    cmp al, -1
    jz end_opt2_while
    cmp al, 0xa
    je opt2_while

    inc byte [total_count]
    cmp byte [ans], al
    je opt2_correct

    mov byte [correct_char], 120
    jmp opt2_skip_correct

    opt2_correct:
    mov byte [correct_char], 32
    inc byte [correct_count]

    opt2_skip_correct:
    lea rdi, [cmp_fmt]
    movzx rsi, byte [ans]
    mov rdx, rax
    movzx rcx, byte [correct_char]
    call printf
    jmp opt2_while
  end_opt2_while:

  pop r13
  pop r12

  mov [file_ptr], r13
  mov [ans_file_ptr], r12

  mov rdi, [ans_file_ptr]
  call fclose

  xor rdx, rdx
  movzx rax, byte [total_count]
  mov rbx, 2
  div rbx
  mov byte [total_count], al

  movzx rax, byte [correct_count]
  sub al, byte [total_count]
  mov byte [correct_count], al

  opt2_end:

  leave
  ret

_opt3:
  push rbp
  mov rbp, rsp

  cmp byte [correct_count], 15
  jge opt3_correct

  lea rdi, [grade_fmt]
  lea rsi, [file_name]
  movzx rdx, byte [correct_count]
  movzx rcx, byte [total_count]
  lea r8, [fail]

  call printf

  opt3_correct:

  lea rdi, [grade_fmt]
  lea rsi, [file_name]
  movzx rdx, byte [correct_count]
  movzx rcx, byte [total_count]
  lea r8, [pass]

  call printf

  leave
  ret

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
      call _opt1
      call _clear_buff
      call getchar
      jmp _control_loop
    opt_2:
      cmp [ans], byte '2'
      jnz opt_3
      call _opt2
      call _clear_buff
      call getchar
      jmp _control_loop
    opt_3:
      cmp [ans], byte '3'
      jnz opt_4
      call _opt3
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

  ; Testing output of file
  mov r12, [file_ptr]
  push r12            ; wrapping file pointer in a push pop

  while_test:
    mov rdi, [file_ptr]
    call fgetc
    cmp al, -1
    jz end_while_test
    mov rdi, rax
    call putchar
    jmp while_test
  end_while_test:

  pop r12

  ; End test

  mov [file_ptr], r12

  mov rdi, [file_ptr]
  call fclose

  xor rdi,rdi
  call exit
