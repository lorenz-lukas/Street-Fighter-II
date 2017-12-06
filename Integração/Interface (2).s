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
############################################### MENU
.eqv VGA_INIT_ADDR   0xFEFFFF40		# FF000000 - C0  0xFEFFFF40  # Endereço inicial da VGA, mas existe um BUG, que pode ser concertado ao subtrair um offest no endereço da VGA
.eqv VGA	     0xFF000000
.eqv SD_INIT	     0x00404000		# ARQUIVO.txt sem header. Addr = Offset.[Caso tenha header Addr = Offset + (137 * 512) = Offset + 0x00011200 (defasagem de setores lógicos/físicos * tamanho do setor)]. Olhe pelo WinHex o offset do seu cartão SD
.eqv SD_INIT_MENU    0x00417000
.eqv SD_MENU_FINAL   0x00593000


.eqv SRAM_MENU0	     0x10014C00
.eqv SRAM_MENU1	     0x10027800
.eqv SRAM_MENU2	     0x1003A400
.eqv SRAM_MENU3	     0x1004D000
.eqv SRAM_MENU_SELEC 0x1005FC00
.eqv SRAM_BLANKA_UM  0x10072800
.eqv SRAM_CHUNLI_UM  0x10085400
.eqv SRAM_DHALSIM_UM 0x10098000
.eqv SRAM_EHONDA_UM  0x100AAC00
.eqv SRAM_GUILE_UM   0x100BD800
.eqv SRAM_KEN_UM     0x100D0400
.eqv SRAM_RYU_UM     0x100E3000
.eqv SRAM_ZANGIEF_UM 0x100F5C00
.eqv SRAM_BLANKA_DOIS  0x10108800
.eqv SRAM_CHUNLI_DOIS  0x1011B400
.eqv SRAM_DHALSIM_DOIS 0x1012E000
.eqv SRAM_EHONDA_DOIS  0x10140C00
.eqv SRAM_GUILE_DOIS   0x10153800
.eqv SRAM_KEN_DOIS     0x10166400
.eqv SRAM_RYU_DOIS     0x10179000
.eqv SRAM_ZANGIEF_DOIS 0x1018BC00

.eqv SRAM_CENARIO    0x10012000		# Endereço da SRAM onde começam os cenários
.eqv SRAM_SPRITE     0x100F3000		# Endereço da SRAM onde começam as sprites
.eqv VGA_QTD_BYTE    76800		# VGA Bytes
.eqv SPRITE_QTD_BYTE 19456

.eqv OFFS_SD_CENA 0x00013000		#OFFSET entre arquivos de cenário no cartão SD
.eqv OFFS_SR_CENA 0x00012C00		#OFFSET entre cenários na SRAM (= Tamanho do cenário = 76800)
.eqv OFFS_SD_CHAR 0x00005000		#OFFSET entre arquivos de sprite no cartão SD
.eqv OFFS_SR_CHAR 0x00004B00		#OFFSET entre sprites na SRAM (= Tamanho da sprite = 19200)
####################################################
.eqv TamX	  160
.eqv TamY	  120

.data
.align 2
PlayerPos:	.word -30, 100, 75, 100  # (Xo(1),Yo(1),Xo(2),Yo(2))    Posição inicial dos dois players	-81<x<178
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
T5:	.word 0x73
k5:	.word 0x00080000
T6:	.word 0x74
k6:	.word 0x00100000
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
	#jal MENU # $v0 = Player 1, $v1 = Player2
	#nop
SaiMenu:
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
	
	jal LeTeclado		# Retorno em $v0 = Player1 e $v1 = Player2
	nop 
		
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $a3, 12($sp)
	lw $s0, 16($sp)
	lw $s1, 20($sp)
	
	andi $s7, $v1, 0x0000FFFF	 #P2
	andi $s6, $v1, 0XFFFF0000	 #P1
	srl $s6, $s6, 16
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
############################################################# MENU #########################################################

MENU:	
	addi $sp,$sp,-4
	sw  $ra,0($sp)
	
	# Printa a tela inicial na tela diretamente do SD. Demora.
	la $a0, SD_INIT
	la $a1, VGA_INIT_ADDR
	la $a2, VGA_QTD_BYTE
	li $v0, 49
	syscall
	
	# Enquanto isso, carrega para a SRAM todos os sprites do menu
	la	$a0, SD_INIT_MENU	
	la	$a1, SRAM_MENU0
 	la	$a2, VGA_QTD_BYTE
 	la	$a3, SD_MENU_FINAL
 	jal GET_CENARIO
 	nop
 	
 	# Printa na tela o Menu na opção 0
	la	$a0, VGA_INIT_ADDR
	li	$a1, SRAM_MENU0
	li	$a3, 76800
 	jal PRINT_CENARIO
 	nop
	move $s0,$zero		# $s0 guarda o estado da opção atual do menu
	move $v0,$zero
	move $a0,$zero
		
MENU_LOOP:	addi $sp,$sp,-4
		sw $s0,0($sp)	
		jal LeTeclado		# Lê do teclado
		nop
		lw $s0,0($sp)
		addi $sp,$sp,4		
		
		andi $a0,$v0,0xFF0000
		beq $a0,0x210000,DESCE
		beq $a0,0x2C0000,SELECAO_DO_MENU
		j MENU_LOOP
		nop
		

SELECAO_DO_MENU:
		beq $s0,$zero,GAME_START_MENU
		beq $s0,0x1,GAME_VS_MENU
		move $a0,$zero			# Se não for nenhum, zera $a0 e $v0 e volta para o menu loop
		move $v0,$zero
		j MENU_LOOP
		nop
		
ESCOLHA_NULL:	move $a0,$zero
		move $v0,$zero
		j MENU_LOOP
		nop	
		
DESCE:		beq $s0,$zero,OPCAO_1
		beq $s0,0x1,OPCAO_2
		beq $s0,0x2,OPCAO_3
		beq $s0,0x3,OPCAO_0
		j MENU_LOOP
		nop

OPCAO_0:	li $s0,0
		
		# Printa na tela o Menu na opção 0
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU0
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		li $v0,132
 		li $a0,200
 		syscall
 		
 		move	$a0, $zero
 		move	$v0, $zero
		j MENU_LOOP
		nop
		
OPCAO_1:	li $s0,1
		
		# Printa na tela o Menu na opção 1
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU1
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		li $v0,132
 		li $a0,200
 		syscall
 		
 		move	$a0, $zero
 		move	$v0, $zero
 		j MENU_LOOP
		nop
		
OPCAO_2:	li $s0,2
		
		# Printa na tela o Menu na opção 2
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU2
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		li $v0,132
 		li $a0,200
 		syscall
 		
 		move	$a0, $zero
 		move	$v0, $zero
 		j MENU_LOOP
		nop

OPCAO_3:	li $s0,3
		
		# Printa na tela o Menu na opção 3
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU3
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		li $v0,132
 		li $a0,200
 		syscall
 		
 		move	$a0, $zero
 		move	$v0, $zero
 		j	MENU_LOOP
		nop
		
####################################################################################################################################

GAME_START_MENU:
		
GAME_VS_MENU:	# Printa na tela o Menu de seleção de personagens
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU_SELEC
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		# Printa na tela o Ryu como seleção do player 1
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_RYU_UM
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		# Printa na tela o Ryu como seleção do player 2
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_RYU_DOIS
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
 		
 		li $v0,132
 		li $a0,200
 		syscall
 		
 		li $s0,0 # Ryu esta selecionado como o player 1
 		li $s1,0 # Ryu esta selecionado como o player 2
 		li $s2,0 # Flag de jogador ativado
 		li $s3,0 # Flag de seleção do jogador 1
 		li $s4,0 # Flag de seleção do jogador 2
 		
 GAME_VS_LOOP: 	addi $sp,$sp,-20
		sw $s0,0($sp)	
		sw $s1,4($sp)
		sw $s2,8($sp)
		sw $s3,12($sp)
		sw $s4,16($sp)
		
		jal LeTeclado		# Lê do teclado
		nop
		
		lw $s0,0($sp)
		lw $s1,4($sp)
		lw $s2,8($sp)
		lw $s3,12($sp)
		lw $s4,16($sp)
		addi $sp,$sp,20				
 		
 		andi $a0,$v0,0xFF0000			# $a0 recebe a leitura do teclado do player 1
		beq $a0,0x2A0000,SELEC_PROX_UM		# Verifica se $a0 foi a letra "V" indicando ir ao próximo personagem
		andi $a1,$v0,0xFF			# $a1 recebe a leitura do teclado do player 2
		beq $a1,0x74,SELEC_PROX_DOIS		# Verifica se $a1 foi o número "6" indicando ir ao próximo personagem
		beq $a0,0x2C0000,PLAYER_UM_SELECIONADO	# Verifica se $a0 foi a letra "t" indicando selecionar personagem player 1
		beq $a1,0x70,PLAYER_DOIS_SELECIONADO		# Verifica se $a1 foi a letra "insert" indicando selecionar personagem player 2
		and $a2,$s3,$s4				# Se ambos os personagens não tiverem sido selecionados, $a0 = 0 sempre
		bnez $a2,BEGIN_PARTIDA			# Se $a0 = 1, quer dizer que os 2 personagens foram selecionados, e a partida pode finalmente ser iniciada
		
		j GAME_VS_LOOP
		nop
		
PLAYER_UM_SELECIONADO:		li $s3,1
				j GAME_VS_LOOP
				nop
				
PLAYER_DOIS_SELECIONADO:	li $s4,1
				j GAME_VS_LOOP
				nop
				
				
SELEC_PROX_UM:	# Avalia a seleção de personagem na tela de seleção
		bne $s3,$zero,GAME_VS_LOOP
		li $s2,0
		# Printa na tela o Menu de seleção de personagens
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU_SELEC
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
		beq $s0,$zero,SELEC_EHONDA_UM
		beq $s0,0x1,SELEC_BLANKA_UM
		beq $s0,0x2,SELEC_GUILE_UM
		beq $s0,0x3,SELEC_KEN_UM
		beq $s0,0x4,SELEC_CHUNLI_UM
		beq $s0,0x5,SELEC_ZANGIEF_UM
		beq $s0,0x6,SELEC_DHALSIM_UM
		beq $s0,0x7,SELEC_RYU_UM
		j GAME_VS_LOOP
		nop

SELEC_PROX_DOIS:
		bne $s4,$zero,GAME_VS_LOOP
		li $s2,1
		# Printa na tela o Menu de seleção de personagens
		la	$a0, VGA_INIT_ADDR
		li	$a1, SRAM_MENU_SELEC
		li	$a3, 76800
 		jal PRINT_CENARIO
 		nop
		
		beq $s1,$zero,SELEC_EHONDA_DOIS
		beq $s1,0x1,SELEC_BLANKA_DOIS
		beq $s1,0x2,SELEC_GUILE_DOIS
		beq $s1,0x3,SELEC_KEN_DOIS
		beq $s1,0x4,SELEC_CHUNLI_DOIS
		beq $s1,0x5,SELEC_ZANGIEF_DOIS
		beq $s1,0x6,SELEC_DHALSIM_DOIS
		beq $s1,0x7,SELEC_RYU_DOIS
		j GAME_VS_LOOP
		nop

SELEC_EHONDA_UM:	li $s0,1
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_EHONDA_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_BLANKA_UM:	li $s0,2
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_BLANKA_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_GUILE_UM:		li $s0,3
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_GUILE_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_KEN_UM:		li $s0,4
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_KEN_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_CHUNLI_UM:	li $s0,5
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_CHUNLI_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_ZANGIEF_UM:	li $s0,6
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_ZANGIEF_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_DHALSIM_UM:	li $s0,7
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_DHALSIM_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_RYU_UM:		li $s0,0
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_RYU_UM
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,$zero,COMPLEMENTA_SELEC_UM
 			j DELAY_MENU
			nop
			
SELEC_EHONDA_DOIS:	li $s1,1
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_EHONDA_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_BLANKA_DOIS:	li $s1,2
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_BLANKA_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_GUILE_DOIS:	li $s1,3
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_GUILE_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_KEN_DOIS:		li $s1,4
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_KEN_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_CHUNLI_DOIS:	li $s1,5
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_CHUNLI_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_ZANGIEF_DOIS:	li $s1,6
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_ZANGIEF_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_DHALSIM_DOIS:	li $s1,7
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_DHALSIM_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
			
SELEC_RYU_DOIS:		li $s1,0
			# Printa na tela o Ryu como seleção do player 1
			la	$a0, VGA_INIT_ADDR
			li	$a1, SRAM_RYU_DOIS
			li	$a3, 76800
	 		jal PRINT_CENARIO
 			nop
 			beq $s2,0x1,COMPLEMENTA_SELEC_DOIS
 			j DELAY_MENU
			nop
 ##################################################################################################################################
BEGIN_PARTIDA:	# Printa a tela inicial na tela diretamente do SD. Demora.
		la $a0, SD_INIT
		la $a1, VGA_INIT_ADDR
		la $a2, VGA_QTD_BYTE
		li $v0, 49
		syscall
		
		move $v0, $s0 # PLAYER 1
		move $v1, $s1 #	PLAYER 2
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		j SaiMenu
		#jr $ra
		#nop
				
 ##################################################################################################################################				
COMPLEMENTA_SELEC_UM:
			beq $s1,0x1,SELEC_EHONDA_DOIS
			beq $s1,0x2,SELEC_BLANKA_DOIS
			beq $s1,0x3,SELEC_GUILE_DOIS
			beq $s1,0x4,SELEC_KEN_DOIS
			beq $s1,0x5,SELEC_CHUNLI_DOIS
			beq $s1,0x6,SELEC_ZANGIEF_DOIS
			beq $s1,0x7,SELEC_DHALSIM_DOIS
			beq $s1,$zero,SELEC_RYU_DOIS
			j GAME_VS_LOOP
			nop
			
COMPLEMENTA_SELEC_DOIS:	beq $s0,0x1,SELEC_EHONDA_UM
			beq $s0,0x2,SELEC_BLANKA_UM
			beq $s0,0x3,SELEC_GUILE_UM
			beq $s0,0x4,SELEC_KEN_UM
			beq $s0,0x5,SELEC_CHUNLI_UM
			beq $s0,0x6,SELEC_ZANGIEF_UM
			beq $s0,0x7,SELEC_DHALSIM_UM
			beq $s0,$zero,SELEC_RYU_UM
			j GAME_VS_LOOP
			nop

 ##################################################################################################################################
DELAY_MENU:	li $v0,132
		li $a0,200
		syscall
		j GAME_VS_LOOP
		nop	
############################################################################################################################			
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
	
	li $a0, 70
	li $v0, 132
	syscall
	
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
LeTeclado:

#carrega o ultimo codigo do Buffer 0 e prepara para comparacao
la	$t0,0xFF100100	#BUFFER 0
la	$s0,0xFF100524	#KEY 1
la	$s4,0xFF10052C	#KEY 4
lb	$t8,0($t0)	#ultima tecla no buffer
la	$t2,X		#Primeira tecla do Jogador 1
la	$s5,T4		#Primeira tecla do Jogador 2
move	$t4,$zero	#inicializa o contador da comparacao
#Carrega os indicadores de escrita de cada jogador
move	$a1,$zero
move	$a2,$zero
#inicializa os valores de retorno
move	$v0,$zero
#move	$v1,$zero	#Invisivel para humanos

#comparar o codigo com as teclas validas
cmp:
lw	$t1,0($t2)	#Carrega o codigo a ser testado
beq	$t8,$t1,kcmp	#Compara o codigo. Se for uma tecla valida vai para comparacao do KeyMap
addi	$t2,$t2,8	#Passa para o proximo codigo
beq	$t1,$zero,TesteFim	#Verifica se acabaram as os codigos para testar
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

and	$t3,$t1,$t3		#'Filtra' o KeyMap
bne	$t1,$t3,TesteFim	#Verifica se a tecla esta sendo pressionada

#A tecla eh valida e esta pressionada:
beq	$s6,$zero,TesteJ2	#Verifica de quem eh a tecla atual
bne	$a1,$zero,TesteFim	#Verifica se ja escreveu na saida do J1
sll	$t8,$t8,16		#Desloca para escrever na saida do J1
or	$v0,$v0,$t8		#Escreve na saida do J1
addi	$a1,$a1,1		#Indica que ja leu para o J1
j	TesteFim
nop
TesteJ2:
bne	$a2,$zero,TesteFim	#Verifica se ja escreveu na saida do J2
or	$v0,$v0,$t8		#Escreve na saida do J2
addi	$a2,$a2,1		#Indica que ja leu para o J2

TesteFim:
lb	$t8,0($t0)		#Carrega a ultima tecla no buffer
la	$t2,X			#Primeira tecla do Jogador 1
addi	$t4,$t4,1		#incrementa o contador de leitura
and	$a0,$a1,$a2		#Verifica se ja leu os dois valores

beq	$a0,1,AnaliseMov	
bne	$t4,100,cmp		#limite de iteracoes para ler as teclas dos jogadores

AnaliseMov:
#Analisa o movimento (andar para direita ou esquerda e abaixar)
li	$t3,8		#Carrega o peso da tecla
move	$t1,$s0		#Copia o KEY1 para $t1
move	$v1,$zero
MOV:
lw	$t7,0($t1)	#carrega o KEY
lw	$t6,4($t2)	#carrega o keymap do .data
and	$t7,$t6,$t7	#'Filtra' o Keymap
#comparacao
bne	$t7,$t6,CMOV	#Verifica se esta pressionado
add	$v1,$v1,$t3	#Soma o peso caso esteja pressionado
CMOV:
addi	$t2,$t2,8	#Passa para o proxima tecla do .data
srl	$t3,$t3,1	#Divide o peso por 2
bne	$t3,0,MOV	#Testa se as comparacoes acabaram

#carrega os dados para analise do jogador 2
slt	$t1,$s5,$t2	#Compara se a analise do movimento do J2 ja foi feito
bne	$t1,$zero,Buff	#Passa para a verificacao do buffer caso o movimento do J2 ja tenha sido analisado
li	$t3,8		#Reinicia o peso
sll	$v1,$v1,16	#Shifta o registrador de retorno
move	$t2,$s5		#Coloca a tecla 4 do .data no $t2
move	$t1,$s4		#Coloca o KEY4 no $t1
j	MOV
nop
Buff:
#recuperando o contador
la	$t1, Cnt
lw	$t1, 0($t1)
#Armazena no Buffer se $t1 == valor max
beq	$t1,150,grava
addi	$t1,$t1,1
sw	$t1,Cnt
jr	$ra
#j	LeTeclado
nop

grava:
#reseta o contador
move	$t1,$zero
sw	$t1,Cnt
#Carregando os Buffers J
la	$s1,BuffJ1
la	$s2,BuffJ2

move	$a0,$zero	#Inicializa o indicador de escrita
move	$t9,$s2		#Seleciona o BuffJ2
andi	$t8,$v0,0xFF	#Seleciona o dado a ser gravado
EscreveBuff:
#Shift para esquerda do Buffer. Seleciona BuffJ1 ou BuffJ2 dependendo da flag $s6
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

bne	$a0,$zero,fim	#Verifica se ja escreveu nos dois
move	$t9,$s1		#Seleciona o BuffJ1
addi	$a0,$a0,1	#Indica que um ja ta escrito
move	$t8,$v0		#prepara o dado a ser escrito
srl	$t8,$t8,16
j	EscreveBuff	
nop
fim:

#exibe na tela (teste somente)
#lw	$a0,0($s1)
#lw	$a1,4($s1)
#lw	$a2,0($s2)
#lw	$a3,4($s2)

jr	$ra
#j	LeTeclado

#######################################################################################################################
MOVIMENTO: # $a0 = X1, $a1 =Y1, $a2 = X2, $a3 = Sprite1, $s0 = Y2, $s1 = Sprite2
 	addi $sp, $sp, -12
 	sw $ra, 0($sp)
 	sw $a3, 4($sp)
 	sw $s1, 8($sp)
 	
 	beq $s6, 2, BAIXO_P1		#21h
	beq $s6, 4, DIREITA_P1		#2Ah
	beq $s6, 8 , ESQUERDA_P1		#22h
	beq $s6, 1, PULO_P1	#22h
	beq $s6, $zero, PARADO_P1

P2:
	beq $s7, $zero, PARADO_P2 
#	beq $s7, 6, BAIXO_FRENTE	#21h
#	beq $s7, 10, BAIXO_TRAS		#21h
##### DEFAULT: 
	la $a3, 0x10101100
	jal IMPRIME
	nop	
BACK_MAIN:
	lw $ra, 0($sp)
	lw $a3, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12	
	jr $ra
	nop

PARADO_P1:
	la $a3, 0x10101100
	jal IMPRIME
	nop
	j P2
	nop
	
DIREITA_P1:		#PARA IMPLEMENTAR A HITBOX, TROQUE O ADDI POR ADD, 2 POR S3 E NA ESQUERDA ADDI POR -2
	
	addi $s3,$a0,8
	jal COLISAO_BORDA
	nop
	
	add $a0, $a0, $s3
	la $a3, 0x10121E00
	jal IMPRIME
	nop

	add $a0, $a0, $s3
	la $a3, 0x10126900
	jal IMPRIME
	nop

	add $a0, $a0, $s3
	la $a3, 0x1012B400
	jal IMPRIME
	nop

	add $a0, $a0, $s3
	la $a3, 0x1012FF00 
	jal IMPRIME
	nop
	j P2
	nop
	
ESQUERDA_P1:

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
	j P2
	nop
PULO_P1:
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
	j P2
	nop
PULO_FRENTE_P1:

PULO_TRAS_P1:

BAIXO_P1:	 #PERSONAGEM ABAIXA E VOLTA, DEVERIA FICAR ABAIXADO ENQUANTO O BOTTÃO ABAIXA É SEGURADO

	la $a3, 0x10147600
	jal IMPRIME
	nop
	jal IMPRIME
	nop
	j P2
	nop
	
BAIXO_FRENTE_P1:
	addi $a0, $a0, 4
	#la $a3, 0x1010A700
	jal IMPRIME
	nop
	j P2
	nop
BAIXO_TRAS_P1:
	addi $a0, $a0, 4
	#la $a3, 0x1010A700
	jal IMPRIME
	nop
	j P2
	nop
PARADO_P2:
	la $s1, 0x1018DB00
	jal IMPRIME
	nop
	j BACK_MAIN
	nop
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
