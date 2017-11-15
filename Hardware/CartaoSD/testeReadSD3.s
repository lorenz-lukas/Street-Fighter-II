#################################################################################
#                       Teste Syscall SD Card Read                              #
#                                                                               #
#  - $a0    =    Origem Addr          [Argumento]                               #
#  - $a1    =    Destino Addr         [Argumento]                               #
#  - $a2    =    Quantidade de Bytes  [Argumento]                               #
#  - $v0    ?    Falha : Sucesso      [Retorno]                                 #
#                                                                               #
#################################################################################
#                           OBSERVAÇÕES                                         #
#                                                                               #
#  - O programa de teste lê sequencialmente "VGA_QTD_BYTE" bytes do cartão SD a #
#     partir do endereço "SD_DATA_ADDR" e grava os bytes lidos sequencialmente  #
#     a partir do endereço de destino "VGA_INI_ADDR", exibindo na tela a imagem #
#     salva no cartão SD.                                                       #
#                                                                               #
#  - O endereço de início dos dados desejados deve ser obtido para cada cartão  #
#     SD usado com o uso de um Hex Editor. Para o Windows, recomendo o programa #
#     WinHex [ver. de avaliação ou Melhores Lojas]. Lembrar de desconsiderar    #
#     os bytes de cabeçalho do arquivo a ser lido.                              #
#                                                                               #
#  - Há um offset de setores entre o endereço lógico (mostrado pelo Hex Editor) #
#     e o endereço físico da memória do cartão SD. O offset deve ser adicionado #
#     ao endereço do dado que se deseja obter.                                  #
#                                                                               #
#  - O hardware e o software de leitura de dados de cartões SD não funciona para#
#     cartões SDHC e SDXC, sendo limitado a cartões SD de no máximo 2 Gb.       #
#                                                                               #
#  - O programa deve funcionar independente da formatação do cartão desde que   #
#     os dados sejam escritos na memória do cartão de maneira sequencial.       #
#                                                                               #
#   - Para converter as imagens .jpg, .png, etc foi utilizado o programa        #
#    Paint.net passando os arquivos para bmp de 24bits. Então deve-se converter #
#    de bmp para um arquivo binário .mif ou .txt utilizando o bmp2oacv2 (não    #
#    gera cabeçalho)                                                            #
#################################################################################

.eqv SD_DATA_ADDR 0x00088000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv VGA_INI_ADDR 0xFEFFFF40		# FF000000 - C0   # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv USER_DATA    0x10012000		# Endereço da SRAM
.eqv VGA_QTD_BYTE 76800			# VGA Bytes

	.data
	
	.text
	
MAIN:
	la	$a0, SD_DATA_ADDR
	la	$a1, USER_DATA
 	la	$a2, VGA_QTD_BYTE
 	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
	# Usado para verificar os dados lidos usando o In System Memory Content Editor
	la	$t0, VGA_INI_ADDR
	la	$t1, USER_DATA
	li	$t3, VGA_QTD_BYTE
WriteVGA:
 	lw	$t2, 0($t1)
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, 4
	addi	$t3, $t3, -4
 	slti	$t4, $t3, 1
	beq	$t4, $zero, WriteVGA
END:	j END
 	