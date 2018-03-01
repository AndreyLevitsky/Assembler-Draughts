.data 0x10090000
lightn:	.word 0xffffffc0
darkn:	.word 0xffffbbb0
menusquare:	.word 0x00000000
darkblue:	.word 0x32154367
darkred:	.word 0xff880000 #0xff33ee55 - зеленые полоски
greenstick:	.word 0xffff99a0
white:		.word 0xffffffff
text:		.asciiz ""
.text
.globl menufon
menufon:
	sw $ra -4($sp)
	lw $t0 lightn #lightn
	lw $t1 darkn #darkn
	la $a1 0x10010000
	move $a0 $t0
	li $t6 1
	li $t4 8
	li $t5 64
menufonlp:	
	bgtz $t6 menufonlpsq
	move $a0 $t1
menufonlpsq:	
	jal printsquare
	move $a1 $v0
	mul $t6 $t6 -1
	addi $t5 $t5 -1
	beqz $t5 menufonprepare2
	addi $t4 $t4 -1
	move $a0 $t0
	bnez $t4 menufonlp
	mul $t6 $t6 -1
	addi $a1 $a1 31744 #32768
	li $t4 8
	j menufonlp
menufonprepare2:
	lw $a0 menusquare
	lw $a2 greenstick
	la $a1 0x10010000
	addi $a1 $a1 65664
	li $t4 6
	li $t5 24
menufonprepare2lp:
	jal printmenusquare
	move $a1 $v0
	addi $t5 $t5 -1
	beqz $t5 menufonprepare3
	addi $t4 $t4 -1
	bnez $t4 menufonprepare2lp
	addi $a1 $a1 32000
	li $t4 6
	j menufonprepare2lp
menufonprepare3:
	la $a1 0x10010000
	addi $a1 $a1 98496
	lw $a0 darkred
	jal printmenucircle
	move $a1 $v0
	lw $a0 darkblue
	jal printmenucircle
	li $a1 0x10010000
	addi $a1 $a1 98496
	lw $a2 white
	jal menuselect
	lw $a0 32896($a1)
	beq $a0 0xff880000 startthegame
	move $v0 $zero
	lw $ra -4($sp)
	jr $ra
startthegame:
	lw $ra -4($sp)
	li $v0 1
	jr $ra
