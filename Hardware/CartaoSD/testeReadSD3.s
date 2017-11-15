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
#   - Para converter as imagens .jpg, .png, etc foi utilizado o programa        #
#    Paint.net passando os arquivos para bmp de 24bits. Ent�o deve-se converter #
#    de bmp para um arquivo bin�rio .mif ou .txt utilizando o bmp2oacv2 (n�o    #
#    gera cabe�alho)                                                            #
#################################################################################

.eqv SD_DATA_ADDR 0x00088000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores l�gicos/f�sicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cart�o SD
.eqv VGA_INI_ADDR 0xFEFFFF40		# FF000000 - C0   # Endere�o inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endere�o da VGA
.eqv USER_DATA    0x10012000		# Endere�o da SRAM
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
 	