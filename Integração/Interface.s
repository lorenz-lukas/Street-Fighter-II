.eqv SD_INIT_CENARIO 0x005A6000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv SD_FIM_CENARIO  0x00677000
.eqv SD_INIT_SPRITE  0x0068A000		#Endereço no cartão SD onde começam os peersonagens
.eqv SD_FIM_SPRITE   0x007A8000		# Sprite ryu_4_1(006D0000) tem tamanho errado (6000) ou seja ryu_4_2(006D6000)
.eqv VGA_INIT_ADDR   0xFEFFFF40		# FF000000 - C0  0xFEFFFF40  # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv VGA	     0xFF000000

.eqv SRAM_CENARIO    0x10012000		# Endereço da SRAM onde começam os cenários
.eqv SRAM_SPRITE     0x100F3000		# Endereço da SRAM onde começam as sprites
.eqv VGA_QTD_BYTE    76800		# VGA Bytes
.eqv SPRITE_QTD_BYTE 19456

.eqv Ryu_cenario     0x100E0400		#0x10012000	#Endereço na SRAM onde começam os cenários
.eqv Ken_x_x	     0X1017FA00#0x1010F200	
.eqv Ryu_1_2	     0x100F3000

.eqv OFFS_SD_CENA 0x00013000		#OFFSET entre arquivos de cenário no cartão SD
.eqv OFFS_SR_CENA 0x00012C00		#OFFSET entre cenários na SRAM (= Tamanho do cenário = 76800)
.eqv OFFS_SD_CHAR 0x00005000		#OFFSET entre arquivos de sprite no cartão SD
.eqv OFFS_SR_CHAR 0x00004B00		#OFFSET entre sprites na SRAM (= Tamanho da sprite = 19200)

.eqv TamX	  160
.eqv TamY	  120

.data
.align 4
PlayerPos:	.word -30, 100, 75, 100  # (Xo(1),Yo(1),Xo(2),Yo(2))    Posição inicial dos dois players	-81<x<178
.align 2
#Teclas do jogador 1
BuffJ1:	.space 8		#buffer que registra a sequencia de teclas do jogador 1
BuffJ2:	.space 8		#buffer que registra a sequencia de teclas do jogador 2
Cnt:	.word 0			
X:	.word 0x22		#codigo da tecla
kX:	.word 0x00000004	#codigo do keymap
V:	.word 0x2A
kV:	.word 0x00000400
C:	.word 0x21
kC:	.word 0x00000002
D:	.word 0x23
kD:	.word 0x00000008
T:	.word 0x2C
kT:	.word 0x00001000
Y:	.word 0x35
kY:	.word 0x00200000
U:	.word 0x3C
kU:	.word 0x10000000
G:	.word 0x34
kG:	.word 0x00100000
H:	.word 0x33
kH:	.word 0x00080000
J:	.word 0x3B
kJ:	.word 0x08000000
#Teclas do jogador 2
T4:	.word 0x6B
k4:	.word 0x00000800
T6:	.word 0x74
k6:	.word 0x00100000
T5:	.word 0x73
k5:	.word 0x00080000
T8:	.word 0x75
k8:	.word 0x00200000
Ins:	.word 0x70
kIns:	.word 0x00010000
Home:	.word 0x6C
kHome:	.word 0x00001000
Pup:	.word 0x7D
kPup:	.word 0x20000000
Del:	.word 0x71
kDel:	.word 0x00020000
End:	.word 0x69
kEnd:	.word 0x00000200
PDown:	.word 0x7A
kPDown:	.word 0x04000000
END:	.word 0x00000000
.align 4	

.text
MAIN:
	#jal MENU
	#nop
	
	jal LOAD_SD_DATA
	nop
	
	la 	$t2, PlayerPos
	lw	$a0, 0($t2)	#a0 tem Xo(1)
	lw	$a1, 4($t2)	#a1 tem Y0(1)
	lw 	$a2, 8($t2)	#a2 tem Xo(2)
	la 	$a3, Ryu_1_2
	lw	$s0, 12($t2)	#s0 tem Y0(2)
	li	$s1, Ken_x_x	
	add 	$v0, $zero, $zero
WHILE:	
	la $a3, Ryu_1_2
	addi $sp, $sp, -24
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $s0, 16($sp)
	sw $s1, 20($sp)
	
	jal IMPRIME   # $a0 = X1, $a1 =Y1, $a2 = X2, $a3 = Sprite1, $s0 = Y2, $s1 = Sprite2
	nop
	
	jal LP		# Retorno em $v0 = Player1 e $v1 = Player2
	nop 
		
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $a3, 12($sp)
	lw $s0, 16($sp)
	lw $s1, 20($sp)
	
	andi $s7, $v1, 0XFFFF0000
	jal MOVIMENTO
	nop
	
	andi $s7, $v1, 0x0000FFFF
	jal MOVIMENTO
	nop
	
	#andi $s7, $v0, 0XFFFF0000
	#srl $s7, $s7, 16
	#jal ATAQUE
	#nop
	
#	jal COLISAO_BORDA
	
	#andi $s7, $v0, 0x0000FFFF
	#jal MOVIMENTO
	#nop
	
	#jal HITBOX
	#nop
	
	# $a0 = X1, $a1 =Y1, $a2 = X2, $a3 = Sprite1, $s0 = Y2, $s1 = Sprite2
	#lw $a0, 0($sp)
	#lw $a1, 4($sp)
	#lw $a2, 8($sp)
	lw $a3, 12($sp)
	#lw $s0, 16($sp)
	lw $s1, 20($sp)
	addi $sp, $sp, 24
	move $s7, $v0
	
	j WHILE
	nop
############# FIM DO JOGO	
	j FIM
	nop
	
LOAD_SD_DATA:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
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
 	
 	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
 	jr $ra
 	nop
################################################ 	
#PRINTA CENÀRIO E SPRITES COM ENDEREÇO RELATIVO#
################################################

IMPRIME:	# $a0 = X1, $a1 =Y1, $a2 = X2, $a3 = Sprite1, $s0 = Y2, $s1 = Sprite2	 
	addi $sp, $sp, -28
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	sw $s1, 24($sp)
	
 	la $a0, VGA_INIT_ADDR 
	li $a1, Ryu_cenario
	li $a3, 76800
 	jal PRINT_CENARIO
 	nop 	
 	
 	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	
 	jal PRINT_SPRITE
 	nop
 	
	add 	$t9, $zero, $a2
	move 	$a2, $a0
	move 	$a0, $t9 
	move	$a1, $s0 # Y2
	move	$s2, $a3
	move 	$a3, $s1 # Sprite2
	move 	$s1, $s2
	
 	jal PRINT_SPRITE
	nop
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	addi $sp, $sp, 28
		 	
 	jr $ra
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
 	bne	$a0, 0x006D0000, BAD_BLOCK	# Tratamento do Bad Block do SD
	addi	$a0, $a0, 0x00006000
BAD_BLOCK:
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
	addi	$sp, $sp, -8
 	sw	$t2, 0($sp)
 	sw	$t4, 4($sp)
 	
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
	addi	$sp, $sp, 8
		
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
################################################### TECLADO #######################################################################
LP:

#Carregando os Buffers J
	la	$s1,BuffJ1
	la	$s2,BuffJ2

#carrega o ultimo codigo do Buffer 0
	la	$t0,0xFF100100	#BUFFER 0
	la	$s0,0xFF100524	#KEY 1
	la	$s4,0xFF10052C	#KEY 4
	lb	$t8,0($t0)	#ultima tecla no buffer
	la	$s5,T4		#Primeira tecla do Jogador 2
	la	$t2,X		#Primeira tecla do Jogador 1
	move	$t4,$zero	#inicializa a flag a ser usada no EscreveBuff

#Analisa o movimento (andar para direita ou esquerda e abaixar)
	li	$t3,8		#Carrega o peso da tecla
	li	$v1,0		#Zera o registrador de retorno
	move	$t1,$s0		#Copia o KEY1 para $t1
MOV:
	lw	$t7,0($t1)	#carrega o KEY
	lw	$t6,4($t2)	#carrega o keymap do .data
	and	$t7,$t6,$t7
#comparacao
	bne	$t7,$t6,CMOV
	add	$v1,$v1,$t3	#Soma o peso caso esteja pressionado
CMOV:
	addi	$t2,$t2,8	#Passa para o proxima tecla do .data
	srl	$t3,$t3,1	#Divide o peso por 2
	bne	$t3,0,MOV	#Testa se as comparacoes acabaram
#carrega os dados para analise do jogador 2
	slt	$t1,$s5,$t2	#Compara se a analise do movimento do J2 ja foi feito
	la	$t2,X		#Carrega X (para a rotina cmp)
	bne	$t1,$zero,cmp	#Passa para a verificacao do buffer caso o movimento do J2 ja tenha sido analisado
	li	$t3,8		#Reinicia o peso
	sll	$v1,$v1,16	#Shifta o registrador de retorno
	move	$t2,$s5		#Coloca a tecla 4 do .data no $t2
	move	$t1,$s4		#Coloca o KEY4 no $t1
	j	MOV
	nop
#comparar o codigo com as teclas validas
cmp:
	lw	$t1,0($t2)	#Carrega o codigo a ser testado
	beq	$t8,$t1,kcmp	#Compara o codigo. Se for uma tecla valida vai para comparacao do KeyMap
	addi	$t2,$t2,8	#Passa para o proximo código
	beq	$t1,$zero,ERRO	#Verifica se acabaram as os codigos para testar
	j	cmp
	nop
#comparar com o keymap e descobrir se a tecla esta sendo pressionada agora
kcmp:
#verifica de qual jogador eh a tecla. Se $s6 = 1 entao eh o jogador 1
	slt	$s6,$t2,$s5
	lw	$t1,4($t2)	#Carrega o keymap da tecla detectada, que esta no .data

#Seleciona entre o Key1 (J1) ou Key4 (J2)
	move	$t9,$s4
	beq	$s6,$zero,KJ2
	move	$t9,$s0
KJ2:
	lw	$t3,0($t9)	
	and	$t3,$t1,$t3
	beq	$t1,$t3,HIT

#Erro: a tecla nao eh valida ou nao esta pressionada
ERRO:
	li	$s6,2		#Seta flag em 2 -> tecla invalida
	li	$v0,0
	li	$t8,0
	j	Contador
	nop
#HIT: a tecla eh valida e esta pressionada
HIT:
	move	$v0,$t8

Contador:
#recuperando o contador
	la	$t1, Cnt
	lw	$t1, 0($t1)
#Armazena no Buffer se $t1 == valor max
	beq	$t1,10001,grava
	addi	$t1,$t1,1
	sw	$t1,Cnt
#	jr	$ra
	j	LP
	nop
grava:
	beq	$t1,10001,EscreveBuff	#Escreve no Buffer - primeira vez
	bne	$s6,$s7,EscreveBuff	#Escreve no Buffer - segunda vez, se tiver uma tecla para escrever do outro jogador
	addi	$t1,$t1,1		#Se nao leu uma tecla do outro jogador, continua o tempinho
	move	$t8,$zero		#$t8 vai ser gravado no buffer
	beq	$t1,20001,EscreveBuff	#Se acabar o tempinho, grava 0 no buffer
#Colocar coisas para chamar cmp
	la	$t2,X		#Primeira tecla do Jogador 1
	la	$t0,0xFF100100	#BUFFER 0
	lb	$t8,0($t0)	#ultima tecla no buffer
	j	cmp	
	nop
EscreveBuff:

	addi	$t1,$t1,1	#Inicia o tempinho
	move	$s7,$s6		#Copia a flag do jogador que gravou a primeira vez
	addi	$t4,$t4,1	#Incrementa a flag que conta quantas vezes escreveu
#Shift para esquerda do Buffer. Seleciona BuffJ1 ou BuffJ2 dependendo da flag $s6
	move	$t9,$s2
	beq	$s6,$zero,BJ2
	move	$t9,$s1
BJ2:
	lw	$t2,4($t9)
	sll	$t2,$t2,8
	lb	$t5,3($t9)
	or	$t2,$t2,$t5
	sw	$t2,4($t9)
	lw	$t2,0($t9)
	sll	$t2,$t2,8
	sw	$t2,0($t9)
#grava no ultimo Byte
	sb	$t8,0($t9)
#Se estiver passando pela primeira vez e nenhuma tecla foi gravada, gravar nada para o outro jogador tambem
	bne	$v0,$zero,leitura2
	li	$s6,0		#seta a flag em 0
	beq	$t4,1,EscreveBuff
#Definir coisas para o cmp
leitura2:
	la	$t2,X		#Primeira tecla do Jogador 1
	la	$t0,0xFF100100	#BUFFER 0
	lb	$t8,0($t0)	#ultima tecla no buffer
	bne	$t4,2,cmp	#testa se ja gravou nos dois buffers

#reinicializa a contagem
	la	$t1, Cnt
	sw	$zero, 0($t1)

#exibe na tela (teste somente)
	lw	$a0,0($s1)
	lw	$a1,4($s1)
	lw	$a2,0($s2)
	lw	$a3,4($s2)

#jr	$ra
#loop da função
#j	LP
#nop
	jr $ra
	nop
#######################################################################################################################
MOVIMENTO: # $a0 = X1, $a1 =Y1, $a2 = X2, $a3 = Sprite1, $s0 = Y2, $s1 = Sprite2
 	addi $sp, $sp, -8
 	sw $ra, 0($sp)
 	sw $a3, 4($sp)
 	beq $s7, 2, BAIXO		#21h
	beq $s7, 4, DIREITA		#2Ah
	beq $s7, 8 , ESQUERDA		#22h
	
	beq $s7, 0x20000, BAIXO		#21h
	beq $s7, 0x40000, DIREITA	
	beq $s7, 0x80000 , ESQUERDA
#	beq $s7, 1, PULO		#23h
#	beq $s7, 5, PULO_FRENTE
#	beq $s7, 9, PULO_TRAS


#	beq $s7, 6, BAIXO_FRENTE	#21h
#	beq $s7, 10, BAIXO_TRAS		#21h
##### DEFAULT: 
	la $a3, 0x10101100
	jal IMPRIME
	nop	
BACK_MAIN:
	lw $ra, 0($sp)
	lw $a3, 4($sp)
	addi $sp, $sp, 8	
	jr $ra
	nop

DIREITA:		#PARA IMPLEMENTAR A HITBOX, TROQUE O ADDI POR ADD, 2 POR S3 E NA ESQUERDA ADDI POR -2
	
	addi $s3,$a0,8
	jal COLISAO_BORDA
	
#	addi $a0, $a0, 2
	add $a0, $a0, $s3
	la $a3, 0x10121E00
	jal IMPRIME
	nop
#	addi $a0, $a0, 2
	add $a0, $a0, $s3
	la $a3, 0x10126900
	jal IMPRIME
	nop
#	addi $a0, $a0, 2
	add $a0, $a0, $s3
	la $a3, 0x1012B400
	jal IMPRIME
	nop
#	addi $a0, $a0, 2
	add $a0, $a0, $s3
	la $a3, 0x1012FF00 
	jal IMPRIME
	nop
	la $a3, 0x100F3000
	j BACK_MAIN
	nop
ESQUERDA:

	addi $s3,$a0,-8
	jal COLISAO_BORDA

#	addi $a0, $a0, -2
	sub $a0, $a0, $s3
	la $a3, 0x10134A00
	jal IMPRIME
	nop
#	addi $a0, $a0, -2
	sub $a0, $a0, $s3
	addi $a3, $a3, 0x4B00
	jal IMPRIME
	nop
#	addi $a0, $a0, -2
	sub $a0, $a0, $s3
	addi $a3, $a3, 0x4B00
	jal IMPRIME
	nop
#	addi $a0, $a0, -2
	sub $a0, $a0, $s3
	addi $a3, $a3, 0x4B00
	jal IMPRIME
	nop
	la $a3, 0x100F3000
	j BACK_MAIN
	nop
PULO:
	addi $a1, $a1, -25
	la $a3, 0x10105C00
	jal IMPRIME
	nop
	addi $a1, $a1, -25
	la $a3, 0x10105C00
	jal IMPRIME
	nop
	la $a3, 0x1010A700
	jal IMPRIME
	nop
	addi $a1, $a1, 25
	la $a3, 0x1010A700
	jal IMPRIME
	nop
	addi $a1, $a1, 25
	la $a3, 0x1010A700
	jal IMPRIME
	nop
	j BACK_MAIN
	nop
PULO_FRENTE:

PULO_TRAS:

BAIXO:	 #PERSONAGEM ABAIXA E VOLTA, DEVERIA FICAR ABAIXADO ENQUANTO O BOTTÃO ABAIXA É SEGURADO

	la $a3, 0x10147600
	jal IMPRIME
	nop
	jal IMPRIME
	nop
	jal IMPRIME
	nop
	j BACK_MAIN
	nop
BAIXO_FRENTE:
	addi $a0, $a0, 4
	#la $a3, 0x1010A700
	jal IMPRIME
	nop
	j BACK_MAIN
	nop
BAIXO_TRAS:
###################################################################################################################################
ATAQUE:  # RETORNA PRA MAIN PELO BACK_MAIN
	addi $sp, $sp, -8
 	sw $ra, 0($sp)
 	sw $a3, 4($sp)
 	
 ###### USAR LÓGICA DO MOVIMENTO, ALTERAR SPRITES SEM ALTERAR A POSIÇÂO	

#################################################################################################################################
##################################################################################################################################
COLISAO_BORDA:
	# recebe como parametro	$a0 = posicao Y
	#  Detector de colisao			 	      #
	#  $a0 = Posicao x -> ret1.y	do SPRITE	      #
	#  $a1 = Posicao y -> ret1.x	do SPRITE	      #
	#  $a2 = Posicao x2 -> ret2.y	do SPRITE	      #
	#  $a3 = Posicao y2 -> ret2.x	do SPRITE	      #

	li $t0, 80		#menor posicao possivel do Y para nao ter colisao nao resolvemos a tempo
	li $t1, -80		#maior posicao possivel do Y para nao ter colisao
	
	
	#addi $s3, $a0, -8

	 
	bgt $t1,$s3,LIMITE_ESQUERDA
	
	bgt $s3,$t0,LIMITE_DIREITA
	
	li $s3, 2
	jr $ra
	#slt $t3,$s3,$t0		# se $t3=1 nao colide
	#bne $t3,$zero,NAO_COLIDE
	
	
##################################################################################################################################
LIMITE_ESQUERDA:
#	la $a0,MSG_COLIDE
#	li $v0,4
#	syscall
	
#	move $a0,$t9
#	li $v0,1
#	syscall	
#	li $v0,1
	li $s3, 0
	
	jr $ra
##################################################################################################################################
LIMITE_DIREITA:
#	la $a0,MSG_NAO_COLIDE
#	li $v0,4
#	syscall	
#	li $v0,0
	li $s3, 0
	
	jr $ra
#######################################################################################
FIM:	j FIM
	nop
