# ##############################################################################
# |
# | EXERCÍCIO: Cálculo de X = (B*B) - 4*A*C
# |
# | MINHAS ANOTAÇÕES:
# |   - Preciso ler três valores: A, B e C.
# |   - Vou guardar A em $s0, B em $s1 e C em $s2.
# |   - A ordem da conta é importante: primeiro as multiplicações, depois a subtração.
# |   - Usarei registradores temporários ($t0, $t1...) para guardar resultados parciais.
# |
# ##############################################################################

# Na seção .data, eu declaro os textos que vou usar para interagir com o usuário.
.data
    prompt_A:   .asciiz "Digite o valor de A: "
    prompt_B:   .asciiz "Digite o valor de B: "
    prompt_C:   .asciiz "Digite o valor de C: "
    resultado:  .asciiz "O resultado de X = (B*B) - 4*A*C é: "

# Na seção .text, eu escrevo as instruções do meu programa.
.text
.global main

main:
# ---- Etapa 1: Leio o valor de A e guardo em $s0 ----
    li   $v0, 4           # Falo para o sistema que quero imprimir um texto.
    la   $a0, prompt_A    # Indico qual texto quero imprimir.
    syscall               # Mando imprimir.

    li   $v0, 5           # Falo para o sistema que quero ler um número inteiro.
    syscall               # Mando ler. O número que o usuário digitar vai para $v0.

    move $s0, $v0         # Guardo o valor de A (que está em $v0) em $s0.

# ---- Etapa 2: Leio o valor de B e guardo em $s1 ----
    li   $v0, 4
    la   $a0, prompt_B
    syscall

    li   $v0, 5
    syscall

    move $s1, $v0         # Guardo o valor de B em $s1.

# ---- Etapa 3: Leio o valor de C e guardo em $s2 ----
    li   $v0, 4
    la   $a0, prompt_C
    syscall

    li   $v0, 5
    syscall

    move $s2, $v0         # Guardo o valor de C em $s2.

# ---- Etapa 4: Calculo a expressão X = (B*B) - 4*A*C ----
    
    # Primeiro, calculo (B*B) e guardo o resultado em um registrador temporário.
    mul  $t0, $s1, $s1    # $t0 = B * B  (lembrando que $s1 guarda o valor de B)

    # Segundo, calculo (4*A*C). Faço isso em partes para ficar mais claro.
    li   $t1, 4           # Carrego o número 4 em um registrador temporário, o $t1.
    mul  $t2, $s0, $s2    # Calculo A*C e guardo o resultado em $t2.
    mul  $t3, $t2, $t1    # Multiplico o resultado (A*C) por 4. Agora $t3 guarda 4*A*C.
    
    # Por fim, faço a subtração na ordem correta: (B*B) - (4*A*C).
    sub  $s6, $t0, $t3    # $s6 = ($t0) - ($t3). O resultado final de X está em $s6.

# ---- Etapa 5: Imprimo o resultado final ----
    # Primeiro, imprimo o texto "O resultado é..."
    li   $v0, 4
    la   $a0, resultado
    syscall

    # Agora, imprimo o número que representa o resultado final.
    li   $v0, 1           # Falo para o sistema que quero imprimir um INTEIRO.
    move $a0, $s6         # Movo o resultado final (de $s6) para $a0 para poder imprimi-lo.
    syscall

# ---- Etapa 6: Encerro o programa de forma limpa ----
    li   $v0, 10          # Falo para o sistema que quero finalizar o programa.
    syscall