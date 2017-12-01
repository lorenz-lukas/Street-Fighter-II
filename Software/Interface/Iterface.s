.eqv SD_DATA_ADDR 0x00404000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv VGA_INI_ADDR 0xFEFFFF40 		# FF000000 - C0  0xFEFFFF40  # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv SRAM         0x10012000		# Endereço da SRAM onde começam os cenários
.eqv SRAM2	  0x100F3000		# Endereço da SRAM onde começam as sprites
.eqv VGA_QTD_BYTE 76800			# VGA Bytes
.eqv CHR_QTD_BYTE 19200
.eqv Ryu_cenario  0x100A8000		#Endereço na SRAM onde começa o cenário do ryu
.eqv SD_DATA_ADD2 0x004E8000		#Endereço no cartão SD onde começam os peersonagens
.eqv OFFS_SD_CENA 0x00013000		#OFFSET entre arquivos de cenário no cartão SD
.eqv OFFS_SR_CENA 0x00012C00		#OFFSET entre cenários na SRAM (= Tamanho do cenário = 76800)
.eqv OFFS_SD_CHAR 0x00005000		#OFFSET entre arquivos de sprite no cartão SD
.eqv OFFS_SR_CHAR 0x00004B00		#OFFSET entre sprites na SRAM (= Tamanho da sprite = 19200)

	.data
	
	.text
	la	$a0, SD_DATA_ADDR
	la	$a1, SRAM
 	la	$a2, VGA_QTD_BYTE
	add	$t5, $zero, $zero
GetCenario:

 	
 	addi	$sp, $sp, -12	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$a0, 0($sp)
 	sw	$a1, 4($sp)
 	sw	$a2, 8($sp)
 	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
 	lw	$a0, 0($sp)
 	lw	$a1, 4($sp)
 	lw	$a2, 8($sp)
 	addi	$sp, $sp, 12
	
	beq	$a0,0x4D5000,FimC
	addi	$a0, $a0, OFFS_SD_CENA
	addi	$a1, $a1, OFFS_SR_CENA
	j	GetCenario
FimC:	nop


	la	$a0, SD_DATA_ADD2
	la	$a1, SRAM2
	la	$a2, CHR_QTD_BYTE
	add	$t5, $zero, $zero	
GetCharacter: 	
 
 	addi	$sp, $sp, -12	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$a0, 0($sp)
 	sw	$a1, 4($sp)
 	sw	$a2, 8($sp)
 	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
 	lw	$a0, 0($sp)
 	lw	$a1, 4($sp)
 	lw	$a2, 8($sp)
 	addi	$sp, $sp, 12
	
	beq	$a0,0x4D5000,FimC
	addi	$a0, $a0, OFFS_SD_CHAR
	addi	$a1, $a1, OFFS_SR_CHAR
	j	GetCharacter

	

PrintCenario:
	la	$t0, VGA_INI_ADDR
	li	$t1, Ryu_cenario
	li	$t3, VGA_QTD_BYTE
LoopCenario:
 	lw	$t2, 0($t1)
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, 4
	addi	$t3, $t3, -4
 	slti	$t4, $t3, 1
	beq	$t4, $zero, LoopCenario
#	beq	$t5, 11, END
#	addi	$t5, $t5, 1
#	li	$a0, 1000
#	li	$v0, 32
#	syscall
	
#	j	LOOPp
	
	
	
END:	j END
 	
