# Seção de Dados: onde preparamos nossas variáveis e textos.
.data
    prompt_base:   .asciiz "Digite o valor da base (b): "
    prompt_altura: .asciiz "Digite o valor da altura (h): "
    texto_area:    .asciiz "A área do triângulo é: "

# Seção de Código: onde ficam as instruções que o processador vai executar.
.text
.globl main

# main: é a etiqueta que marca o início do nosso programa.
main:
    # ---- Etapa 1: Ler o valor da base (b) ----
    li   $v0, 4              # Prepara o serviço 4 (imprimir string).
    la   $a0, prompt_base    # Carrega o endereço do texto para pedir a base como argumento.
    syscall                  # Executa a impressão do texto.

    li   $v0, 5              # Prepara o serviço 5 (ler um inteiro).
    syscall                  # Executa a leitura. O número digitado fica em $v0.
    
    move $s0, $v0            # Movemos o valor da base para um registrador salvo, $s0.

    # ---- Etapa 2: Ler o valor da altura (h) ----
    li   $v0, 4              # Prepara o serviço 4 novamente.
    la   $a0, prompt_altura  # Carrega o endereço do texto para pedir a altura.
    syscall                  # Imprime o texto.

    li   $v0, 5              # Prepara o serviço 5 novamente.
    syscall                  # Lê o segundo número, que fica em $v0.

    move $s1, $v0            # Movemos o valor da altura para outro registrador salvo, $s1.

    # ---- Etapa 3: Calcular A = (b * h) / 2 ----
    # Primeiro, a multiplicação (b*h). Usamos um registrador temporário ($t0) para o resultado.
    mul  $t0, $s0, $s1       # $t0 = $s0 * $s1   (ou seja, t0 = b * h)

    # Agora, a divisão por 2.
    li   $t1, 2              # Carregamos o número 2 em outro registrador temporário.
    div  $t0, $t1            # Dividimos o resultado da multiplicação ($t0) por 2 ($t1).
                             # O resultado (quociente) é guardado no registrador especial LO.
    
    mflo $s2                 # 'Move From LO'. Movemos o resultado final de LO para $s2.
                             # Agora, $s2 contém o valor da área (A).

    # ---- Etapa 4: Exibir o resultado final ----
    li   $v0, 4              # Prepara o serviço 4 para imprimir o texto final.
    la   $a0, texto_area     # Carrega o endereço do texto do resultado.
    syscall                  # Imprime "A área do triângulo é: ".

    li   $v0, 1              # Prepara o serviço 1 (imprimir um INTEIRO).
    move $a0, $s2            # Movemos o resultado final (de $s2) para o registrador de argumento $a0.
    syscall                  # Imprime o número da área na tela.

    # ---- Etapa 5: Encerrar o programa ----
    li   $v0, 10             # Prepara o serviço 10 (finalizar o programa).
    syscall                  # Executa o encerramento.