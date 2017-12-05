.eqv SD_INIT_CENARIO 0x005A6000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv SD_FIM_CENARIO  0x00677000
.eqv SD_INIT_SPRITE  0x0068A000		#Endereço no cartão SD onde começam os peersonagens
.eqv SD_FIM_SPRITE   0x006CB000		# Sprite ryu_4_1(006D0000) tem tamanho errado (6000) ou seja ryu_4_2(006D6000)
.eqv VGA_INIT_ADDR   0xFEFFFF40		# FF000000 - C0  0xFEFFFF40  # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv VGA	     0xFF000000

.eqv SRAM_CENARIO    0x10012000		# Endereço da SRAM onde começam os cenários
.eqv SRAM_SPRITE     0x100F3000		# Endereço da SRAM onde começam as sprites
.eqv VGA_QTD_BYTE    76800		# VGA Bytes
.eqv SPRITE_QTD_BYTE 19456

.eqv Ryu_cenario     0x10095400		#0x10012000	#Endereço na SRAM onde começam os cenários
.eqv Ryu_x_x	     0x1010F200	
.eqv Ryu_1_2	     0x100F3000

.eqv OFFS_SD_CENA 0x00013000		#OFFSET entre arquivos de cenário no cartão SD
.eqv OFFS_SR_CENA 0x00012C00		#OFFSET entre cenários na SRAM (= Tamanho do cenário = 76800)
.eqv OFFS_SD_CHAR 0x00005000		#OFFSET entre arquivos de sprite no cartão SD
.eqv OFFS_SR_CHAR 0x00004B00		#OFFSET entre sprites na SRAM (= Tamanho da sprite = 19200)

.eqv TamX	  160
.eqv TamY	  123

.data
PlayerPos:	.word -30,100,110,100  # (Xo(1),Yo(1),Xo(2),Yo(2))    Posição inicial dos dois players	-81<x<178
.align 4	

.text
MAIN:
	la	$a0, SD_INIT_CENARIO
	la	$a1, SRAM_CENARIO
 	la	$a2, VGA_QTD_BYTE
 	la	$a3, SD_FIM_CENARIO
 	jal GET_CENARIO
 	nop
 	
	la	$a0, SD_INIT_SPRITE	# Endereço do ryu
	la	$a1, SRAM_SPRITE
	la	$a2, SPRITE_QTD_BYTE
	la	$a3, SD_FIM_SPRITE
	jal GET_SPRITE
 	nop
	 
 	la	$a0, VGA_INIT_ADDR 
	li	$a1, Ryu_cenario
	li	$a3, 76800
 	jal PRINT_CENARIO
 	nop 	
 	
 	la 	$t2, PlayerPos
	lw	$a0, 0($t2)	#a0 tem Xo(1)
	lw	$a1, 4($t2)	#a1 tem Y0(1)
	lw 	$a2, 8($a2)	#a2 tem Xo(2)
	li 	$a3, Ryu_1_2

 	jal PRINT_SPRITE
 	nop
 	
 	
	add 	$t9, $zero, $a2
	move 	$a2, $a0
	move 	$a0, $t9
	li 	$a3, Ryu_x_x
	
 	jal PRINT_SPRITE
	nop
	
	 	 	
 	j END
 	nop
 	
 ##################################################################################################################################
GET_CENARIO:
 	addi	$sp, $sp, -20	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$a0, 0($sp)
 	sw	$a1, 4($sp)
 	sw	$a2, 8($sp)
 	sw	$a3, 12($sp)
 	sw	$ra, 16($sp)
	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
 	lw	$a0, 0($sp)
 	lw	$a1, 4($sp)
 	lw	$a2, 8($sp)
 	lw	$a3, 12($sp)
 	lw	$ra, 16($sp)
 	addi	$sp, $sp, 20
	
	beq	$a0,$a3, FIM_CENARIO
	addi	$a0, $a0, OFFS_SD_CENA
	addi	$a1, $a1, OFFS_SR_CENA
	j	GET_CENARIO
	nop
FIM_CENARIO: jr $ra
	nop
####################################################################################################################################
GET_SPRITE: 		
 	addi	$sp, $sp, -20	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$a0, 0($sp)
 	sw	$a1, 4($sp)
 	sw	$a2, 8($sp)
 	sw	$a3, 12($sp)
 	sw	$ra, 16($sp)
 	
	li	$v0, 49			# Syscall 49 - SD Card Read
	syscall
	
 	lw	$a0, 0($sp)
 	lw	$a1, 4($sp)
 	lw	$a2, 8($sp)
 	lw	$a3, 12($sp)
 	lw	$ra, 16($sp)
 	addi	$sp, $sp, 20
	
	beq	$a0,$a3,FIM_SPRITE
	addi	$a0, $a0, OFFS_SD_CHAR
	addi	$a1, $a1, OFFS_SR_CHAR
	j	GET_SPRITE
	nop
	
FIM_SPRITE:	jr $ra
	nop
######################################################################################################################################
PRINT_CENARIO:
	addi	$sp, $sp, -12
 	sw	$t2, 0($sp)
 	sw	$t4, 4($sp)
 	sw	$ra, 12($sp)
	
LOOP_CENARIO:
 	lw	$t2, 0($a1)
	sw	$t2, 0($a0)
	addi	$a0, $a0, 4
	addi	$a1, $a1, 4
	addi	$a3, $a3, -4
 	slti	$t4, $a3, 1
	beq	$t4, $zero, LOOP_CENARIO
	
 	lw	$t2, 0($sp)
 	lw	$t4, 4($sp)
 	lw	$ra, 12($sp)
	addi	$sp, $sp, 12
		
	jr $ra
	nop
####################################################################################################################################
PRINT_SPRITE:

	addi	$sp, $sp, -24	#salva os valores de a0, a1 e a2 na pilha para recuperá=los caso sejam alterados pelo syscall
 	sw	$t0, 0($sp)
 	sw	$t1, 4($sp)
 	sw	$t2, 8($sp)
 	sw	$t3, 12($sp)
 	sw	$t5, 16($sp)
 	sw	$t6, 20($sp)
 	
	li 	$t0, 320
	mult 	$a1, $t0		# 320*y
	mflo	$t1
	add 	$t0,$t1,$a0		# +x 
	
	la 	$t1, VGA
	add	$t0,$t1,$t0    # endereço inicial de impressão do sprite ( VGA + 320*X+Y)
	
	move	$t2, $zero
	move	$t3, $zero	# INICIO DO PRINT
	move	$t8, $zero
	addi	$t9, $zero, TamX
	add $t4, $zero, 1	# CONTADOR
	addi $t6,$zero, 5400
	
	slt $t1, $a0, $a2	# Se X do player analisado é menor que do outro player 
	bne $t1, $zero, LOOP	# Caso player esteja na esquerda da tela, vai direto pra loop. 
	addi $t3, $zero, TamX	# Tamanho em X
	move $t8, $t3	
	addi $t4, $zero, -1
	add $t9, $zero, $zero
	
LOOP:	
	lb 	$t5,0($a3)
	sb 	$t5, 0($t6)
	addi	$a3, $a3, 1
	add	$t6, $t6, $t4
	add	$t3, $t3, $t4
	bne	$t3, $t9, LOOP
############	LOOP EXTERNO: 	
	addi 	$t6, $t0, 320
	move 	$t0,$t6			##########
	addi 	$t2, $t2, 1
	move 	$t3, $t8	
	bne 	$t2, TamY, LOOP
	
 	lw	$t0, 0($sp)
 	lw	$t1, 4($sp)
 	lw	$t2, 8($sp)
 	lw	$t3, 12($sp)
 	lw	$t5, 16($sp)
 	lw	$t6, 20($sp)
 	addi	$sp, $sp, 24
	
	jr $ra
	nop

END:	j END
	nop
