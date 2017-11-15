.eqv SD_DATA_ADDR 0x00088000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv SD_RYU_ADDR 0x00178000

.eqv VGA_INI_ADDR 0xFEFFFF40		# FF000000 - C0   # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv USER_DATA    0x10012000		# Endereço da SRAM
.eqv RYU_DATA     0x10024C00
.eqv VGA_QTD_BYTE 76800			# VGA Bytes
.eqv VGA_QTD_RYU_BYTE 38400

	.data
	
	.text
	
MAIN:
	la	$a0, SD_DATA_ADDR
	la	$a1, USER_DATA
 	la	$a2, VGA_QTD_BYTE
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
	la	$a0, SD_RYU_ADDR
	la	$a1, RYU_DATA
	la	$a2, VGA_QTD_RYU_BYTE
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
	jal PrintChar
	
END:	j END
	
PrintChar:
	la	$t0, VGA_INI_ADDR
	la	$t1, RYU_DATA
	li	$t3, VGA_QTD_RYU_BYTE
WriteVGA2:
 	lw	$t2, 0($t1)
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, 4
	addi	$t3, $t3, -4
 	slti	$t4, $t3, 1
	beq	$t4, $zero, WriteVGA2
	jr $ra
