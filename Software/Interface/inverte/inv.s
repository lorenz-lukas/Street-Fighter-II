.eqv VGA 0xFF000000
.eqv RYU 0x100F3000
.eqv RYU_cenario 0x100A8000

.data

SIZE: .word 160,120
POSo: .byte 0,120,255,0  # (Yo,Xo)    Posi��o inicial dos dois players	
.align 4
SPRITE2: .byte 60,89,0,0
BUFFER2: .space 5400
SPRITE3: .byte 92,90,0,0
BUFFER3: .space 8400
FILE1: .asciiz "menu.bin"
FILE2: .asciiz "neutral(3).bin"
FILE3: .asciiz "lp(1).bin"
.align 9
.text
MAIN:	
	jal PRINT_CENARIO
###############################################################
	la $a0,FILE2 
	li $a1,0
	li $a2,0
	li $v0,13
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0
	la $a1,BUFFER2	
	li $a2,5340
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	
	la $t0,POSo
	lb $a0,0($t0) #eixo y dire��o i
	lb $a1,1($t0) #eixo x dire��o -j
	
	la $t0, SPRITE2 
	lb $a2,0($t0) # TAMANHO X
	lb $a3,1($t0) # TAMANHO Y
	la $t7, BUFFER2	
	
	jal PRINT_SPRITE
	
##################################################################		
	la $a0,FILE3 
	li $a1,0
	li $a2,0
	li $v0,13
	syscall

# Le o sprite para a memoria BUFFER
	move $a0,$v0
	la $a1,BUFFER3	
	li $a2,8372
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	
	la $t0,POSo
	lb $a0,2($t0) #eixo x dire��o i
	lb $a1,1($t0) #eixo y dire��o -j
	
	la $t0, SPRITE3 
	lb $a2,0($t0) # TAMANHO X
	lb $a3,1($t0) # TAMANHO Y
	
	jal PRINT_SPRITE_INV
FIM:
	addi $v0, $zero, 10
	syscall
	
PRINT_SPRITE:
	li $t0, 320
	mul $t1,$a1,$t0		# 320*x
	add $t0,$t1,$a0		# +y  ( Valor da coordenada Yo)
	
	la $t1,VGA
	add $t0,$t1,$t0    # endere�o inicial de impress�o do sprite ( VGA + 320*X+Y)
	
	move $t2, $zero
	move $t3, $zero
	
	addi $t6,$zero, 5400
	
LOOP:	lb $t5,0($t7)
	sb $t5, 0($t6)
	addi $t7, $t7, 1
	addi $t6, $t6, 1
	addi $t3, $t3, 1
	bne $t3, $a2, LOOP
############	LOOP EXTERNO: 	
	addi $t6, $t0, 320
	move $t0,$t6
	addi $t2, $t2, 1
	move $t3, $zero	
	bne $t2, $a3, LOOP
	
	jr $ra
#####################################################################################
PRINT_SPRITE_INV:
	li $t0, 320
	mul $t1,$a1,$t0		# 320*y
	add $t0,$t1,$a0		# +x  ( Valor da coordenada Yo)
	
	la $t1,VGA
	add $t0,$t1,$t0    # endere�o inicial de impress�o do sprite ( VGA + 320*X+Y)
	
	move $t2, $zero
	move $t3, $a2	# Tamanho em X
	
	addi $t6,$zero, 8400
	la $t7, BUFFER3
	add $t7, $t7, $a2
	
LOOPinv:lb $t5,0($t7)	#BUFFER
	sb $t5, 0($t6)	#VGA
	addi $t7, $t7, 1
	addi $t6, $t6, -1
	addi $t3, $t3, -1
	bne $t3, $zero, LOOPinv
############	LOOP EXTERNO: 	

	addi $t6, $t0, 320
	move $t0,$t6
	addi $t2, $t2, 1
	move $t3, $a2	
	bne $t2, $a3, LOOPinv
	
	jr $ra
#######################################################################################
PRINT_CENARIO:
# Abre o arquivo com tela de fundo ######################################################### PRINT BACKGROUND
	la $a0,FILE1
	li $a1,0
	li $a2,0
	li $v0,13
	syscall

# Le o arquivo para a memoria VGA
	move $a0,$v0
	la $a1,VGA
	li $a2,76800
	li $v0,14
	syscall

#Fecha o arquivo
	li $v0,16
	syscall
	
	jr $ra 