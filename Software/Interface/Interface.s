.eqv SD_INIT_CENARIO 0x00404000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv SD_INIT_SPRITE 0x004E8000		#Endereço no cartão SD onde começam os peersonagens
.eqv VGA_INIT_ADDR 0xFEFFFF40 		# FF000000 - C0  0xFEFFFF40  # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv VGA	  0xFF000000

.eqv SRAM_CENARIO         0x10012000		# Endereço da SRAM onde começam os cenários
.eqv SRAM_SPRITE	  0x100F3000		# Endereço da SRAM onde começam as sprites
.eqv VGA_QTD_BYTE 76800			# VGA Bytes
.eqv SPRITE_QTD_BYTE 19456

.eqv Ryu_cenario  0x1005D000		#Endereço na SRAM onde começa o cenário do ryu

.eqv OFFS_SD_CENA 0x00013000		#OFFSET entre arquivos de cenário no cartão SD
.eqv OFFS_SR_CENA 0x00012C00		#OFFSET entre cenários na SRAM (= Tamanho do cenário = 76800)
.eqv OFFS_SD_CHAR 0x00005000		#OFFSET entre arquivos de sprite no cartão SD
.eqv OFFS_SR_CHAR 0x00004B00		#OFFSET entre sprites na SRAM (= Tamanho da sprite = 19200)

.eqv TamX	  160
.eqv TamY	  122

.data
PlayerPos:	.byte 15,100,0,0  # (Xo(1),Yo(1),Xo(2),Yo(2))    Posição inicial dos dois players	
.align 4	

.text
MAIN:
	la	$a0, SD_INIT_CENARIO
	la	$a1, SRAM_CENARIO
 	la	$a2, VGA_QTD_BYTE
 	jal GET_CENARIO
 	nop
 	
 	la	$a0, SD_INIT_SPRITE	# Endereço do ryu
	la	$a1, SRAM_SPRITE
	la	$a2, SPRITE_QTD_BYTE
 	jal GET_SPRITE
 	nop
 	
 	la 	$t2, PlayerPos
	lb	$a0, 0($t2)	#a0 tem Xo(1) 
	lb	$a1, 1($t2)	#a1 tem Y0(1)
	li 	$t7, SRAM_SPRITE
	 	
 	jal PRINT_CENARIO
 	nop
 	
 	jal PRINT_SPRITE
 	nop
 	j END
 	nop
 	
GET_CENARIO:
 	addi	$sp, $sp, -16	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$a0, 0($sp)
 	sw	$a1, 4($sp)
 	sw	$a2, 8($sp)
 	sw	$ra, 12($sp)
	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
 	lw	$a0, 0($sp)
 	lw	$a1, 4($sp)
 	lw	$a2, 8($sp)
 	lw	$ra, 12($sp)
 	addi	$sp, $sp, 16
	
	beq	$a0,0x004D5000, FIM_CENARIO
	addi	$a0, $a0, OFFS_SD_CENA
	addi	$a1, $a1, OFFS_SR_CENA
	j	GET_CENARIO
	nop
FIM_CENARIO: jr $ra
	nop

GET_SPRITE: 		
 	addi	$sp, $sp, -16	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$a0, 0($sp)
 	sw	$a1, 4($sp)
 	sw	$a2, 8($sp)
 	sw	$ra, 12($sp)
 	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
 	lw	$a0, 0($sp)
 	lw	$a1, 4($sp)
 	lw	$a2, 8($sp)
 	lw	$ra, 12($sp)
 	addi	$sp, $sp, 16
	
	beq	$a0,0x4ED000,FIM_SPRITE
	addi	$a0, $a0, OFFS_SD_CHAR
	addi	$a1, $a1, OFFS_SR_CHAR
	j	GET_SPRITE
	nop
	
FIM_SPRITE:	jr $ra
	nop
###################################################################################################
PRINT_CENARIO:
	la	$t0, VGA_INIT_ADDR
	li	$t1, Ryu_cenario
	li	$t3, 76800
LOOP_CENARIO:
 	lw	$t2, 0($t1)
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, 4
	addi	$t3, $t3, -4
 	slti	$t4, $t3, 1
	beq	$t4, $zero, LOOP_CENARIO
	
	jr $ra
	nop
##################################################################################################
PRINT_SPRITE:	
	li 	$t0, 320
	mult 	$a1, $t0		# 320*y
	mflo	$t1
	add 	$t0,$t1,$a0		# +x 
	
	la 	$t1, VGA
	add	$t0,$t1,$t0    # endereço inicial de impressão do sprite ( VGA + 320*X+Y)
	
	move	$t2, $zero
	move	$t3, $zero
	
	addi $t6,$zero, 5400
LOOP:	
	lb 	$t5,0($t7)
	sb 	$t5, 0($t6)
	addi	$t7, $t7, 1
	addi	$t6, $t6, 1
	addi	$t3, $t3, 1
	bne	$t3, TamX, LOOP
############	LOOP EXTERNO: 	
	addi 	$t6, $t0, 320
	move 	$t0,$t6			##########
	addi 	$t2, $t2, 1
	move 	$t3, $zero	
	bne 	$t2, TamY, LOOP
	
	jr $ra
	nop
END:	j END
	nop