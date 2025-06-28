.data 
    prompt_A:  .asciiz "Digite o valor de A: "
    prompt_B:  .asciiz "Digite o valor de B: "
    prompt_C:  .asciiz "Digite o valor de C: "
    resultado: .asciiz "O resulto de X = (B*H) / 2 é: "


.text
.global main

    main:

    li  $v0, 4
    syscall
    la  $a0, prompt_A
    syscall

    move $s0, $v0