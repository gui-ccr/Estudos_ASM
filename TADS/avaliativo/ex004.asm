# [cite_start]A diretiva .data inicia a seção de declaração de dados do programa. [cite: 435]
.data 
    # 'numero1:' é uma etiqueta que marca o endereço de memória desta string.
    # [cite_start].asciiz declara uma string de texto (ASCII) que termina com um caractere nulo ('z'). [cite: 436]
	numero1:   .asciiz "Digite o valor de A: "
	numero2:   .asciiz "Digite o valor de B: "
	resultado: .asciiz "O resultado de A + B = : "

# [cite_start]A diretiva .text inicia a seção de código, onde ficam as instruções executáveis. [cite: 437]
.text
# A diretiva .globl main torna a etiqueta 'main' visível globalmente,
# designando-a como o ponto de entrada oficial do programa.
.globl main

# 'main:' é a etiqueta que marca o início da execução do nosso código.
main:

# ---- Etapa 1: Ler o valor de A ----
	[cite_start]li   $v0, 4           # 'li' (Load Immediate): Carrega o código 4 (imprimir string) no registrador de serviço $v0. [cite: 439]
	[cite_start]la   $a0, numero1     # 'la' (Load Address): Carrega o endereço da string 'numero1' no registrador de argumento $a0. [cite: 440]
	[cite_start]syscall               # 'syscall' (System Call): Executa a chamada de sistema (neste caso, imprime a string). [cite: 441]

	[cite_start]li   $v0, 5           # Carrega o código 5 (ler inteiro) em $v0. [cite: 443]
	syscall               # Executa a chamada de sistema (lê o inteiro). [cite_start]O valor digitado pelo usuário fica em $v0. [cite: 444]

	[cite_start]move $s0, $v0         # 'move': Copia o valor lido (A) de $v0 para o registrador salvo $s0 para armazenamento. [cite: 447]

# ---- Etapa 2: Ler o valor de B ----
	li   $v0, 4           # Prepara o serviço para imprimir a próxima string.
	la   $a0, numero2     # Carrega o endereço da string 'numero2' em $a0.
	syscall               # Imprime o prompt para o número B.

	li   $v0, 5           # Prepara o serviço para ler o segundo inteiro.
	syscall               # Lê o segundo inteiro, que é colocado em $v0.

	move $s1, $v0         # Move o valor lido (B) de $v0 para o registrador salvo $s1.

# ---- Etapa 3: Somar A + B ----
	[cite_start]add  $s3, $s0, $s1    # 'add': Soma os valores contidos em $s0 (A) e $s1 (B) e armazena o resultado em $s3. [cite: 482]

# ---- Etapa 4: Exibir o resultado ----
	li   $v0, 4           # Prepara o serviço para imprimir a string de resultado.
	la   $a0, resultado   # Carrega o endereço da string 'resultado' em $a0.
	syscall               # Imprime o texto do resultado.

	[cite_start]li   $v0, 1           # Carrega o código 1 (imprimir inteiro) em $v0. [cite: 487]
	[cite_start]move $a0, $s3         # Move o resultado da soma (que está em $s3) para $a0 para que possa ser impresso. [cite: 488]
	[cite_start]syscall               # Imprime o número que está em $a0. [cite: 489]

# ---- Etapa 5: Encerrar o programa ----
	li   $v0, 10          # Carrega o código 10 (finalizar programa / exit) em $v0.
	syscall               # Executa a chamada final, encerrando o programa de forma limpa.