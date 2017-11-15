#################################################################################
#                       Teste Syscall SD Card Read                              #
#                                                                               #
#  - $a0    =    Origem Addr          [Argumento]                               #
#  - $a1    =    Destino Addr         [Argumento]                               #
#  - $a2    =    Quantidade de Bytes  [Argumento]                               #
#  - $v0    ?    Falha : Sucesso      [Retorno]                                 #
#                                                                               #
#################################################################################
#                           OBSERVA��ES                                         #
#                                                                               #
#  - O programa de teste l� sequencialmente "VGA_QTD_BYTE" bytes do cart�o SD a #
#     partir do endere�o "SD_DATA_ADDR" e grava os bytes lidos sequencialmente  #
#     a partir do endere�o de destino "VGA_INI_ADDR", exibindo na tela a imagem #
#     salva no cart�o SD.                                                       #
#                                                                               #
#  - O endere�o de in�cio dos dados desejados deve ser obtido para cada cart�o  #
#     SD usado com o uso de um Hex Editor. Para o Windows, recomendo o programa #
#     WinHex [ver. de avalia��o ou Melhores Lojas]. Lembrar de desconsiderar    #
#     os bytes de cabe�alho do arquivo a ser lido.                              #
#                                                                               #
#  - H� um offset de setores entre o endere�o l�gico (mostrado pelo Hex Editor) #
#     e o endere�o f�sico da mem�ria do cart�o SD. O offset deve ser adicionado #
#     ao endere�o do dado que se deseja obter.                                  #
#                                                                               #
#  - O hardware e o software de leitura de dados de cart�es SD n�o funciona para#
#     cart�es SDHC e SDXC, sendo limitado a cart�es SD de no m�ximo 2 Gb.       #
#                                                                               #
#  - O programa deve funcionar independente da formata��o do cart�o desde que   #
#     os dados sejam escritos na mem�ria do cart�o de maneira sequencial.       #
#                                                                               #
#################################################################################

.eqv SD_DATA_ADDR 0x0058000#3E8000            # GBA_24b_bit.txt com header. Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores l�gicos/f�sicos * tamanho do setor)
.eqv VGA_INI_ADDR 0xFEFFFF40 #FF000000 - B8
#.eqv VGA_END_ADDR 0xFF012C00 #0xFF012C00 - B8
#s.eqv USER_DATA    0x1000F800
.eqv USER_DATA    0x10010000
.eqv VGA_QTD_BYTE 76800  #98304# #            # VGA Bytes

    .data

    .text

    la      $a0, SD_DATA_ADDR
#    la      $a1, USER_DATA              # Usado para verifica��o dos dados lidos
    la      $a1, VGA_INI_ADDR
    la      $a2, VGA_QTD_BYTE
main:
    addi $sp, $sp, 4
    sw $a0, 0($sp)
    
    li      $v0, 49                     # Syscall 49 - SD Card Read
    syscall
    
    lw $a0, 0($sp)
    addi $sp, $sp, -4
    j end

# Usado para verificar os dados lidos usando o In System Memory Content Editor
    la      $t0, VGA_INI_ADDR
    la      $t1, USER_DATA
    li      $t3, VGA_QTD_BYTE

#    la      $t4, VGA_END_ADDR

writeVGA:
    lw      $t2, 0($t1)
    sw      $t2, 0($t0)
    addi    $t0, $t0, 4
    addi    $t1, $t1, 4
#    bne	    $t0, $t4, writeVGA 
    addi    $t3, $t3, -4
    slti    $t4, $t3, 1
    beq     $t4, $zero, writeVGA

end:
    la      $a1, VGA_INI_ADDR
    la      $a2, VGA_QTD_BYTE
    addi $a0, $a0, 0x00018000
    j main
