# ##############################################################################
# |
# | EXEMPLO SIMPLES: Soma de Dois Números
# |
# | Autor: Seu parceiro de estudos e códigos
# | Data: 28/06/2025
# |
# | DESCRIÇÃO:
# |   Este programa é uma implementação comentada do exemplo encontrado
# |   nas páginas 12 e 13 do arquivo 'aula3.pdf'.
# |   O objetivo é solicitar dois números inteiros ao usuário, calcular
# |   a soma deles e exibir o resultado final na tela.
# |
# ##############################################################################


# ##############################################################################
# |
# |____> SEÇÃO DE DADOS (.data)
# |       Aqui declaramos as strings (textos) que serão usadas para
# |       interagir com o usuário. 
# |
# ##############################################################################
.data
# |____> Textos para solicitar os números e para exibir o resultado.
numerol: .asciiz "Numerol: "      # Etiqueta para o texto do primeiro prompt 
numero2: .asciiz "Numero2: "      # Etiqueta para o texto do segundo prompt 
result:  .asciiz "Resultado: "    # Etiqueta para o texto que precede o resultado 


# ##############################################################################
# |
# |____> SEÇÃO DE CÓDIGO (.text)
# |       Aqui fica a lógica do programa, as instruções a serem executadas.
# |
# ##############################################################################
.text
.globl main
main:
# |
# |____> ETAPA 1: Ler o primeiro número
# |
# |------> Imprime o texto "Numerol: " na tela.
    li   $v0, 4              # Carrega em $v0 o código do serviço "imprimir string". 
    la   $a0, numerol        # Carrega em $a0 o endereço da string 'numerol' a ser impressa. 
    syscall                  # Pede ao sistema para executar o serviço (imprimir). 

# |------> Lê o número inteiro digitado pelo usuário.
    li   $v0, 5              # Carrega em $v0 o código do serviço "ler inteiro". 
    syscall                  # Pede ao sistema para executar o serviço (ler). 
                             # Após a execução, o número digitado fica armazenado em $v0.

# |------> Salva o primeiro número em um registrador seguro.
    move $s0, $v0            # Copia o valor lido (de $v0) para $s0 (registrador salvo). 
                             # Fazemos isso para não perder o valor, pois $v0 é temporário.

# |
# |____> ETAPA 2: Ler o segundo número
# |       (O processo é idêntico ao da ETAPA 1)
# |
# |------> Imprime o texto "Numero2: " na tela.
    li   $v0, 4              # Serviço "imprimir string". 
    la   $a0, numero2        # Endereço da string 'numero2'. 
    syscall                  # Executa. 

# |------> Lê o segundo número inteiro.
    li   $v0, 5              # Serviço "ler inteiro". 
    syscall                  # Executa. O número lido fica em $v0. 

# |------> Salva o segundo número em outro registrador seguro.
    move $s1, $v0            # Copia o valor lido (de $v0) para $s1. 

# |
# |____> ETAPA 3: Realizar a Adição
# |       Agora que temos os dois números em $s0 e $s1, podemos somá-los.
# |
    add  $s2, $s0, $s1       # Soma o conteúdo de $s0 e $s1 e armazena o resultado em $s2. 
                             # Formato: add $destino, $fonte1, $fonte2

# |
# |____> ETAPA 4: Imprimir o Resultado Final
# |
# |------> Imprime o texto "Resultado: " na tela.
    li   $v0, 4              # Serviço "imprimir string". 
    la   $a0, result         # Endereço da string 'result'. 
    syscall                  # Executa. 

# |------> Imprime o número que é o resultado da soma.
    li   $v0, 1              # Carrega em $v0 o código do serviço "imprimir INTEIRO". 
    move $a0, $s2            # Copia a soma (que está em $s2) para $a0, que é o argumento. 
    syscall                  # Pede ao sistema para imprimir o número que está em $a0. 

# |
# |____> ETAPA FINAL: Encerrar o programa
# |       É uma boa prática finalizar o programa de forma limpa.
# |
exit:
    li   $v0, 10             # Carrega o código do serviço "encerrar programa".
    syscall                  # Executa, finalizando o programa.

# ####################### FIM DO CÓDIGO MIPS #######################