# Seção de Dados: onde ficam os textos que vamos usar.
.data
    prompt_n:    .asciiz "Digite um número (N) para calcular o fatorial: "
    texto_fat:   .asciiz "O fatorial de N é: "

# Seção de Código: onde ficam as instruções do programa.
.text
.globl main

main:
    # ---- Etapa 1: Ler o valor de N ----
    li   $v0, 4              # Prepara o serviço 4 (imprimir string).
    la   $a0, prompt_n       # Carrega o endereço do texto para pedir o número N.
    syscall                  # Imprime o texto.

    li   $v0, 5              # Prepara o serviço 5 (ler um inteiro).
    syscall                  # Lê o número digitado, que fica em $v0.

    move $s0, $v0            # Movemos o valor de N para um registrador salvo, $s0.

    # ---- Etapa 2: Inicializar as variáveis para o loop ----
    # Corresponde a: int resultado = 1;
    li   $s1, 1              # Inicializamos o registrador do resultado ($s1) com 1.
    
    # Corresponde a: int i = 1;
    li   $t0, 1              # Inicializamos nosso contador 'i' ($t0) com 1.

    # ---- Etapa 3: O Loop Fatorial ----
    # A etiqueta abaixo marca o início do nosso laço de repetição.
loop_fatorial:
    # A condição do loop em Java é 'i <= n'. Em MIPS, é mais fácil testar a condição de SAÍDA.
    # A condição de saída é 'i > n'. Se for verdade, pulamos para o fim do loop.
    bgt  $t0, $s0, fim_loop  # 'Branch if Greater Than': Se $t0 > $s0, pule para a etiqueta 'fim_loop'.

    # Corpo do loop, corresponde a: resultado = resultado * i;
    mul  $s1, $s1, $t0       # Multiplica o resultado atual ($s1) pelo contador 'i' ($t0).

    # Incremento do contador, corresponde a: i++;
    addi $t0, $t0, 1         # Adiciona 1 ao nosso contador 'i'.

    # Volta ao início do loop para a próxima verificação.
    j    loop_fatorial       # 'Jump': Pula incondicionalmente para a etiqueta 'loop_fatorial'.

# A etiqueta abaixo marca o ponto para onde o código pula quando o loop termina.
fim_loop:

    # ---- Etapa 4: Exibir o resultado final ----
    li   $v0, 4              # Prepara o serviço para imprimir o texto do resultado.
    la   $a0, texto_fat      # Carrega o endereço do texto.
    syscall                  # Imprime "O fatorial de N é: ".

    li   $v0, 1              # Prepara o serviço para imprimir um INTEIRO.
    move $a0, $s1            # Movemos o resultado final (de $s1) para o registrador de argumento $a0.
    syscall                  # Imprime o valor do fatorial.

    # ---- Etapa 5: Encerrar o programa ----
    li   $v0, 10             # Prepara o serviço 10 (finalizar o programa).
    syscall                  # Executa o encerramento.