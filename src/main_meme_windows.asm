; Main file for Lab
;
; Meme Team:
;

segment .data
  %define INDENT 0x9,0x9,0x9
  menu         db INDENT,"STATE DMV DRIVERS EXAMINATION",0xa,\
                  INDENT,"-----------------------------",0xa,\
                  INDENT,"1. Enter Applicant Data File Name",0xa,\
                  INDENT,"2. Grade Applicant Examination",0xa,\
                  INDENT,"3. Display Applicant Results",0xa,\
                  INDENT,"4. Exit The Program",0xa,\
                  INDENT,"-----------------------------",0xa,\
                  INDENT,"Enter Option 1, 2, 3, or 4: ", 0x0
  header      db  0xa,0xa,0xa,\
                  INDENT,"Applicant %s",0xa,0xa,\
                  INDENT," DMV     Applicant",0xa,\
                  INDENT,"-------------------",0xa,0xa,0xa,0
  cmp_fmt db      INDENT," %c       %c %c",0xa,0
  correct_count db 0
  total_count db 0
  pass db "PASS",0
  fail db "FAIL",0
  grade_fmt db    0xa,\
                  INDENT,"Department of Motor Vehicles",0xa,\
                  INDENT,"Driving Exam",0xa,\
                  INDENT,"Applicant: %s",0xa,\
                  INDENT,"Correct Answers: %d/%d",0xa,0x0
  grade_fmt2 db   INDENT,"Score: %s",0xa,0
  input_string db "%c",0x0
  clear db "cls",0x0
  opt_4_ans db INDENT,"Good Bye",0xa,0x0
  invalid_opt_ans db INDENT,"invalid option",0x0
  file_input db "%s",0x0
  file_mode db "r",0x0
  error db "[ERROR] File Not Found",0xa,0x0
  ans_file_name db "datafiles/Answers.txt",0
  opt1_prompt db INDENT,"Enter file name: ",0x0


segment .bss
  ans resb 1
  file_name resb 32
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
  sub rsp, 32
  opt1_start:
  lea rcx, [opt1_prompt]
  call printf
  lea rcx, [file_input]
  lea rdx, [file_name]
  call scanf
  lea rcx, [file_name]
  lea rdx, [file_mode]
  call fopen
  mov [file_ptr], rax
  xor rax,rax
  cmp [file_ptr],rax 
  jnz opt1_end

  lea rcx, [error]
  call printf
  call _clear_buff
  jmp opt1_start

  opt1_end:

  leave
  ret

_opt2:
  push rbp
  mov rbp, rsp
  sub rsp, 32

  mov byte [correct_count], 0
  mov byte [total_count], 0
  lea rcx, [header]
  lea rdx, [file_name]
  call printf

  lea rcx, [ans_file_name]
  lea rdx, [file_mode]
  call fopen
  mov [ans_file_ptr], rax
  cmp byte [ans_file_ptr], 0
  jnz opt2_next

  lea rcx, [error]
  call printf
  call _clear_buff
  jmp opt2_end
  opt2_next:

  mov r12, [ans_file_ptr]
  mov r13, [file_ptr]

  opt2_while:
    mov rcx, [ans_file_ptr]
    call fgetc
    cmp al, -1
    jz end_opt2_while

    mov [ans], al
    mov rcx, [file_ptr]
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
    lea rcx, [cmp_fmt]
    movzx rdx, byte [ans]
    mov r8, rax
    movzx r9, byte [correct_char]
    call printf
    jmp opt2_while
  end_opt2_while:


  mov [file_ptr], r13
  mov [ans_file_ptr], r12

  mov rcx, [ans_file_ptr]
  call fclose

  opt2_end:

  leave
  ret

_opt3:
  push rbp
  mov rbp, rsp
  sub rsp, 32

  cmp byte [correct_count], 15
  jge opt3_correct

  lea rcx, [grade_fmt]
  lea rdx, [file_name]
  movzx r8, byte [correct_count]
  movzx r9, byte [total_count]
  call printf
  lea rcx, [grade_fmt2]
  lea rdx, [fail]
  call printf
  jmp opt3_end

  opt3_correct:

  lea rcx, [grade_fmt]
  lea rdx, [file_name]
  movzx r8, byte [correct_count]
  movzx r9, byte [total_count]
  call printf
  lea rcx, [grade_fmt2]
  lea rdx, [pass]
  call printf

  opt3_end:

  leave
  ret

_clear_buff:
  push rbp
  mov rbp,rsp
  sub rsp, 32

  call getchar
  while:
    cmp rax, 0x0a
    jnz while

  leave
  ret


main:
  push rbp
  mov rbp, rsp
  sub rsp, 32

  xor rax,rax
  mov [file_ptr], rax
  
  _control_loop:
    ; int system(const char *command
    lea rcx, [clear]
    call system

    ; int printf(const char *format, ...)
    lea rcx, [menu]
    call printf

    ; int scanf(const char *format, ...)
    lea rcx, [input_string]
    mov rdx, ans
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
      mov rcx, [file_ptr]
      call fclose
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
      lea rcx, [opt_4_ans]
      call printf
      jmp _end_control
    invalid_opt:
      lea rcx, [invalid_opt_ans]
      call printf
      call _clear_buff
      call getchar
      jmp _control_loop
  _end_control:


  xor rax,rax
  cmp [file_ptr], rax
  jz end

  end:

  xor rcx,rcx
  call exit
