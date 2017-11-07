.data
	VELOCIDADE: .float 20,40,50,60,70,80#m/s
	COSTHETA: .float 0.2588190451 # 75º
	SINTHETA: .float 0.96592582628 # 75º
	TEMPO: .float 0.1
	xmax: .float 24.0
	ymax: .float 32.0
	DOIS: .float 2.0
	g: .float -9.82
	POS0: .word 0xFF000000
	COR: .word 0x0000000

.text
add $a3, $zero, $zero
la $a2, VELOCIDADE
## Preenche a tela de preto
PREENCHE:
	la $t1,0xFF012C00 #carrega o endereço final do Bitmap Display
	la $s2,0xFF000000 #carrega o endereço inicial do Bitmap Display
	la $s1,0xFFFFFFFF
LOOP: 	beq $s2,$t1,MAIN
	sb $s1,0($s2)
	addi $s2,$s2,1
	j LOOP
	
MAIN:	move $a0, $a2
	lw $a0, 0($a0)
	mtc1 $a0, $f0
	#addi $v0, $zero, 4
	#syscall

	#addi $v0, $zero, 6
	#syscall
	#jal TECLADO
	
	#addi $at, $zero, 10
	#mult $t0, $at
	#mflo $t0
	#add $t0, $t0, $t1
	#mtc1 $t0, $f0
	#cvt.s.w $f0, $f0
	
	#lwc1 $f0, VELOCIDADE
	# f0 tem Vinicial 
	#Calcula VX
	
	la $a0, COSTHETA
	lwc1 $f1, 0($a0)#f1 tem costheta
	
	la $a0, SINTHETA
	lwc1 $f2, 0($a0)#f2 tem sintheta
	
	la $a0, TEMPO
	lwc1 $f4, 0($a0)#f4 tem tempo
	
	mul.s $f2, $f0, $f2 # Vy = V*sin(theta)
	mul.s $f0, $f0, $f1 # f0 = Vx = V*cos(theta)
	mov.s $f1, $f2 # f1 = Vy
	
	#INICIALIZAÇÂO
	mtc1 $zero, $f11 # $f10 = Sx
	cvt.s.w $f11, $f11
	mtc1 $zero,$f12 # $f11 = Sy
	cvt.s.w $f12, $f12
	
	add $t0, $zero, $zero
	addi $t1 $zero, 200
	lwc1 $f3, TEMPO
	lwc1 $f4, g
	lwc1 $f5, DOIS

POSICAO:beq $t0, $t1, RETURN
	
	round.w.s $f30, $f11
	mfc1 $a0, $f30 # X
	round.w.s $f31, $f12
	mfc1 $a1, $f31 # Y
	
	jal POSX
	jal POSY
	jal VELY
	jal PRINTBTYE
	
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	####### DELAY #######
	#addi $a0,$zero,10
	#addi $v0,$zero,32
	#syscall
	#####################
	lw $a0,0($sp)
	lw $v0,4($sp)
	addi $sp,$sp,8
	
	addi $t0, $t0, 1
	j POSICAO
	
RETURN:	beq $a3, 7, FIM
	addi $a2, $a2, 4
	addi $a3, $a3, 1
	j MAIN
FIM: j FIM
	#addi $v0, $zero, 10
	#syscall

POSX:# Sx = Sx + Vx*t
	mul.s $f10, $f0, $f3
	add.s $f11, $f11 ,$f10
	jr $ra
	
VELY:# Vy = Vy + g*t
	mul.s $f9, $f4, $f3
	add.s $f1, $f1, $f9
	jr $ra

POSY:# Sy = Sy + Vy*t + 0.5*g*t^2
	mul.s $f8, $f3, $f3
	mul.s $f8, $f8, $f4
	div.s $f8, $f8, $f5
	mul.s $f9, $f1, $f3
	add.s $f9, $f9, $f8
	add.s $f12, $f12, $f9
	jr $ra
	
PRINTBTYE:addi $sp,$sp,-28
	sw $t0,0($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $s1,12($sp)
	sw $s2,16($sp)
	sw $s3,20($sp)
	sw $s0,24($sp)
	
	slti  $s0,$a0,320#Verificam se a posição a ser impressa ultrapassa os limites da tela, se sim, pula a impressão para não interromper o programa
	beq $s0,$zero,RET
	slti $s0,$a1,240
	beq $s0,$zero,RET 
	slti  $s0,$a0,0
	bne $s0,$zero,RET
	slti $s0,$a1,0
	bne $s0,$zero,RET 
		
	addi $t0,$zero, 239 #239 #se a posição 0x0 for no canto inferior esquerdo
	
	# Y
	sub $t1,$t0,$a1  ## Se a posição 0x0 for a mesma do mars, comente essa linha e a anterior
	
	la $t2,POS0 #carrega o endereço da posição 0x0 do bitmap display para ser calculada a posição do pixel a ser impresso
	lw $s2,0($t2)#carrega o conteúdo do endereço, $s2 = 0xFF000000
	
	la $t2,COR #carrega o endereço da cor a ser impressa
	lw $s1,0($t2) #carrega a cor a ser impressa no registrador t0
	
	#### SUBSTITUIÇÂO MUL POR MULT #############################
	#mul $t1,$t1,320 #320*y	para dar o offset necessário
	addi $at, $zero, 320
	mult $t1, $at
	mflo $t1
	############################################################
	
	
	add $s3, $s2,$t1
	add $s3, $s3,$a0 
	move $s1, $zero
	sb $s1,0($s3)## A posição que tem que ser impressa é 320*y + x 
	move $v0,$s3
	
RET:	
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	lw $s1,12($sp)
	lw $s2,16($sp)
	lw $s3,20($sp)
	lw $s0,24($sp)
	addi $sp,$sp,28
	
	jr $ra
