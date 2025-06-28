# Define a área onde as variáveis (dados) são declaradas.
.data
	numero1:   .asciiz "Digite o valor de A: "        
	numero2:   .asciiz "Digite o valor de B: "        
	numero3:   .asciiz "Digite o valor de C: "        
	resultado: .asciiz "O resultado de X = (A+B)/C é: "        
	
# Define a área onde as instruções do programa (código) são escritas.
.text
.globl main

main:
# ---- Etapa 1: Ler o valor de A ----
	li   $v0, 4           # Serviço 4: Imprimir string.
	la   $a0, numero1     # Argumento: o endereço do texto "numero1".
	syscall               # Executa a impressão.

	li   $v0, 5           # Serviço 5: Ler inteiro.
	syscall               # Executa a leitura. O valor lido fica em $v0.

	move $s0, $v0         # Salva o valor de A em $s0. (Note: sem syscall aqui!)

# ---- Etapa 2: Ler o valor de B ----
	li   $v0, 4
	la   $a0, numero2
	syscall

	li   $v0, 5
	syscall

	move $s1, $v0         # Salva o valor de B em $s1.

# ---- Etapa 3: Ler o valor de C ----
	li   $v0, 4
	la   $a0, numero3
	syscall

	li   $v0, 5
	syscall

	move $s2, $v0         # Salva o valor de C em $s2.

# ---- Etapa 4: Calcular X = (A + B) / C ----
	# Primeiro, a soma (A + B)
	add  $s3, $s0, $s1    # $s3 = $s0 + $s1  (sendo $s0=A, $s1=B)
	
	# Agora, a divisão
	div  $s3, $s2         # Divide o resultado da soma ($s3) por C ($s2).
	                      # O quociente vai para o registrador especial LO.
	
	mflo $s4              # Move o resultado (quociente) de LO para $s4.
	                      # Agora, $s4 contém o valor final de X.

# ---- Etapa 5: Imprimir o resultado final ----
	li   $v0, 4           # Serviço 4: Imprimir string.
	la   $a0, resultado   # Argumento: o endereço do texto "resultado".
	syscall

	li   $v0, 1           # Serviço 1: Imprimir INTEIRO.
	move $a0, $s4         # Argumento: o valor final de X, que está em $s4.
	syscall

# ---- Etapa 6: Encerrar o programa ----
	li   $v0, 10          # Serviço 10: Finalizar o programa.
	syscall