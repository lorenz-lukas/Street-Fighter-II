.eqv VGA 0xFF000000
.data
	TEMPO: .float 0.0445
	BARRAN: .asciiz "\n"
	PI: .float 3.141592654
	RASO: .float 180.0
	xmax: .float 24.0
	ymax: .float 32.0
	UM: .float 1.0
	DOIS: .float 2.0
	one: .float -1.0
	g: .float -9.8
	velocidade: .asciiz "Forneça os valores da velocidade inicial (m/s):\n"
	angulo: .asciiz "Forneça a angulação do tiro (graus):\n"
	Vx: .asciiz "\nVelocidade na direção x: \n"
	Vy: .asciiz "\nVelocidade na direção y: \n"
	x: .asciiz "\nPosição X:\n"
	y: .asciiz "\nPosição Y:\n"
	POS0: .word 0xFF000000
	COR: .word 0x00000000
.globl MAIN
.text
MAIN:la $a0, velocidade
	addi $v0, $zero, 4
	syscall

	addi $v0, $zero, 6
	syscall
	
	mov.s $f1, $f0 #f1 = V
	
	la $a0,angulo
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 6
	syscall #f0 = teta
	
	# CONVERTENDO GRAUS EM RADIANOS
	lwc1 $f2, PI
	mul.s $f0, $f0, $f2
	lwc1 $f2, RASO
	div.s $f0, $f0, $f2 
	
	jal TETA # Resultado na pilha
	sub.s $f3, $f3, $f3
	add $t0, $zero, $zero
	jal SOMATORIO # $f3 = sin(teta)
	mul.s $f0, $f1, $f3 # $f0 = Vy = V*sin(teta)
	#mov.s $f12, $f0
	
	#la $a0, Vy
	#addi $v0, $zero, 4
	#syscall
	
	#addi $v0, $zero, 2
	#syscall
	
	mul.s $f3, $f3, $f3 # f3 = sin^2(teta)
	lwc1 $f2, UM	
	sub.s  $f3, $f2, $f3
	sqrt.s $f3, $f3 # $f3 = cos(teta)
	mul.s $f1, $f1, $f3 #$ f12 = Vx = V*cos(teta)
	#mov.s $f12, $f1
	
	#la $a0,Vx
	#addi $v0, $zero, 4
	#syscall
	
	#addi $v0, $zero, 2
	#syscall
	
	# $f0 = Vy
	# $f1 = Vx
	# 
	######## CALCULO DA POSIÇÂO ##########
	mtc1 $zero, $f10 # $f10 = Sx
	cvt.s.w $f10, $f10
	mtc1 $zero,$f11 # $f11 = Sy
	cvt.s.w $f11, $f11
	mov.s $f3 $f10#, UM # $f3 = Delta (t)
	lwc1 $f9, g # GRAVIDADE
	lwc1 $f20, TEMPO
	lwc1 $f7, DOIS # cte float
	addi $t0, $zero, 0
	addi $t6,$zero,1000
	addi $a0,$zero,0
	addi $a1,$zero,0
	
#	mov.s $f11, $f12
#	addi $v0, $zero, 2#
#	syscall
	
POSICAO:
	beq $t6,$t0,PULA
	

#	mov.s  $f12, $f11
#	addi $v0, $zero, 1
#	syscall
	
#	move $s7,$a0
#	la $a0,BARRAN
#	addi $v0,$zero,4
#	syscall		
#	move $a0,$s7
	
#	move $a3,$a1
#	move $a1,$a0
#	addi $v0, $zero, 2
#	syscall
#	move $a3,$a1
	
#	move $s7,$a0
#	la $a0,BARRAN
#	addi $v0,$zero,4
#	syscall		
#	move $a0,$s7
	
#	mov.s  $f12, $f11	
	
	

	ceil.w.s $f30, $f10
	mfc1 $a0, $f30
	ceil.w.s $f31, $f11
	mfc1 $a1, $f31
	
	#mov.s $f12, $f11
	#addi $v0, $zero, 2
	#syscall
	
	jal POSICAOx 
	jal POSICAOy
	
	jal PRINTBTYE
		
	
	#floor.w.s $f10, $f10
	
# 	mov.s $f12, $f10
#	addi $v0, $zero, 2#
#	syscall
	
#	la $a0,x
#	addi $v0, $zero, 4
#	syscall
	
#	mov.s $f12, $f10
#	addi $v0, $zero, 2
#	syscall
	#floor.w.s $f11, $f11
	
#	la $a0,y
#	addi $v0, $zero, 4
#	syscall
	
#	mov.s $f12, $f10
#	addi $v0, $zero, 1#
#	syscall
##################################################################################################################
	
	
	addi $t0,$t0,1
	add.s $f3,$f3,$f20
	
	
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	addi $a0,$zero,10
	addi, $v0,$zero,32
	syscall
	lw $a0,0($sp)
	lw $v0,4($sp)
	addi $sp,$sp,8
	
	
	
	
	j POSICAO
PULA:	######################################
	addi $v0,$zero,10
	syscall
	
TETA:move $s7, $ra  # $f1 = V, $f2 = teta
	addi $t0, $zero, 10 # Número de iterações que aproximam sen(teta)
	add $t1, $zero, $zero # CONTADOR
	addi $s0, $zero, 2  #cte
	lwc1 $f2, one # cte float -1.0	
LOOP:lwc1 $f3, UM
	divu $t1, $s0 
	mfhi $t2 # (0,1) == (PAR, IMPAR)
	beq $t2, $zero, POS 
	mov.s $f3, $f2 # (-1) ^ N
POS:mul $t3, $t1, $s0 	
	addi $t3, $t3, 1 # $t3 = 2N+1 
	addi $t4, $zero, 1
	jal POT #teta ^ (2N+1+) ; $f3 = POT
	addi $t4, $zero, 1
	addi $t5, $zero, 1
	jal FATORIAL  # $t4 = Fat
	mtc1 $t4, $f4 #FATORIAL
	cvt.s.w $f4, $f4 #FATORIAL
	div.s $f4, $f3, $f4 # POT/FAT
	addi $sp, $sp, -4   
	swc1 $f4 , 0($sp)  # Armazena na Pilha	
	beq $t1, $t0, EXIT1 
	addi $t1, $t1, 1
	j LOOP
	
POT:mul.s $f3, $f3, $f0 #teta^(2N + 1)
	beq $t4, $t3, EXIT  # $t3 = 2N+1; $t4 = CONTADOR DE POT
	addi $t4, $t4, 1
	j POT
EXIT:jr $ra
FATORIAL:mult $t5, $t4
	mflo $t4 
	beq $t5, $t3, EXIT
	addi $t5, $t5, 1
	j FATORIAL	
EXIT1:jr $s7 
SOMATORIO:lwc1 $f2, 0($sp)
	add.s $f3, $f3, $f2
	addi $sp, $sp, 4
	beq $t0, 10, EXIT
	addi $t0, $t0, 1
	j SOMATORIO
POSICAOx: mul.s $f4, $f1, $f3  # $f4 = V*t
	add.s $f10, $f10, $f4
#	mov.s $f10,$f4
	jr $ra
POSICAOy:mul.s $f8, $f3, $f3 # t^2
	mul.s $f8, $f8, $f9 # g*t^2	
	div.s $f8, $f8, $f7 # (g*t^2)/2
	mul.s $f6, $f0, $f3 # Vy*t
	add.s $f6, $f6, $f8 # Vy*t + (g*t^2)/2
	add.s $f11, $f11, $f6 # Sy + Vy*t + (g*t^2)/2 
#	mov.s $f11,$f6

	#mov.s $f12, $f11
	#addi $v0, $zero, 2#
	#syscall
	jr $ra
	
PRINTBTYE:
	addi $sp,$sp,-28
	sw $t0,0($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $s1,12($sp)
	sw $s2,16($sp)
	sw $s3,20($sp)
	sw $s0,24($sp)
	
	slti  $s0,$a0,320
	beq $s0,$zero,RET
	slti $s0,$a1,240
	beq $s0,$zero,RET 
	slti  $s0,$a0,0
	bne $s0,$zero,RET
	slti $s0,$a1,0
	bne $s0,$zero,RET 
		
	addi $t0,$t0,239 #se a posição 0x0 for no canto inferior esquerdo
	sub $t1,$t0,$a1  ## Se a posição 0x0 for a mesma do mars, comente essa linha e a anterior
	
	la $t2,POS0 #carrega o endereço da posição 0x0 do bitmap display para ser calculada a posição do pixel a ser impresso
	lw $s2,0($t2)#carrega o conteúdo do endereço, $s2 = 0xFF000000
	
	la $t2,COR #carrega o endereço da cor a ser impressa
	lw $s1,0($t2) #carrega a cor a ser impressa no registrador t0
	
	mul $t1,$t1,320 #320*y	para dar o offset necessário
	add $s3, $s2,$a0 
	add $s3, $s3,$t1 
	
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

		
