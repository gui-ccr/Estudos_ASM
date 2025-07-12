# ##############################################################################
# |
# | MEU PRIMEIRO PROGRAMA EM ASSEMBLY (Exemplo Simples)
# |
# | OBJETIVO:
# |   Este programa demonstra os conceitos mais básicos:
# |   - Definir dados (uma string de texto).
# |   - Escrever instruções de código.
# |   - Usar chamadas de sistema (syscall) para imprimir texto e números.
# |   - Encerrar o programa de forma limpa.
# |
# ##############################################################################


# A diretiva .data diz ao montador que, a partir daqui, eu vou declarar
# [cite_start]os dados e variáveis que meu programa vai usar. [cite: 450, 461]
.data
    # 'mensagem:' é uma etiqueta (um apelido) para o endereço de memória onde o texto será guardado.
    # [cite_start]'.asciiz' é o tipo de dado: uma string de texto (ASCII) que termina em nulo (z = zero). [cite: 436, 451]
    mensagem: .asciiz "Olá, Assembly! O número da sorte de hoje é: "


# [cite_start]A diretiva .text diz ao montador que agora começam as instruções executáveis do programa. [cite: 452, 464]
.text
# A diretiva .globl main torna a etiqueta 'main' visível para o sistema,
# marcando-a como o ponto de partida oficial do programa.
.globl main

# 'main:' é a etiqueta que marca o início da execução do meu código principal.
main:

    # ---- Etapa 1: Imprimir a mensagem de texto ----

    li   $v0, 4           # 'li' = Load Immediate. Eu carrego o número 4 no registrador $v0.
                          # [cite_start]O número 4 é o código do serviço "imprimir uma string" para o syscall. [cite: 439, 453]

    la   $a0, mensagem    # 'la' = Load Address. Eu carrego o endereço de memória da minha 'mensagem' no registrador $a0.
                          # [cite_start]O registrador $a0 é usado para passar argumentos para os serviços do sistema. [cite: 440, 454]

    syscall               # 'syscall' = Chamada de Sistema. Eu peço ao sistema operacional para executar a ação
                          # [cite_start]que eu configurei: imprimir a string ($v0=4) cujo endereço está em $a0. [cite: 441, 455]

    # ---- Etapa 2: Preparar e imprimir um número inteiro ----

    li   $s0, 42          # 'li' = Load Immediate. Eu carrego o número 42 diretamente no registrador $s0.
                          # Eu uso um registrador salvo ($s) para guardar meu número.

    li   $v0, 1           # Agora, eu mudo o serviço no $v0. Carrego o número 1, que é o código
                          # [cite_start]do serviço "imprimir um número INTEIRO". [cite: 458]

    move $a0, $s0         # 'move'. Eu copio o número 42 que estava em $s0 para o registrador de argumento $a0.
                          # [cite_start]Eu preciso fazer isso para que o 'syscall' saiba qual número imprimir. [cite: 480]

    syscall               # Eu chamo o sistema novamente. Desta vez, como $v0 é 1, ele executa a
                          # impressão do número inteiro que está em $a0.

    # ---- Etapa 3: Encerrar o programa ----

    li   $v0, 10          # Eu carrego o número 10 no registrador $v0.
                          # O número 10 é o código do serviço "finalizar o programa" (exit).

    syscall               # Eu chamo o sistema uma última vez para encerrar a execução de forma limpa.

# ####################### FIM DO PROGRAMA #######################