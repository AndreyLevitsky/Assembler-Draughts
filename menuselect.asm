.data 0x10090200
menua:	.asciiz "a"
menud:	.asciiz "d"
.text
.globl menuselect
menuselect:
	sw $ra ($sp)
	lh $t6 menua
	lh $t7 menud
	move $a0 $a2
	jal menuselectframe
menuselectlp:		
	li $v0 12
	syscall
	beq $t6 $v0 menuprinta
	beq $t7 $v0 menuprintd
	beq $v0 10 menuendselect
	j menuselectlp
menuprinta:
	lw $t8 32896($a1)
	beq $t8 0xff880000 menuprintd
	lw $a0 1028($a1)
	jal menuselectframe
	addi $a1 $a1 -384
	move $a0 $a2
	jal menuselectframe
	j menuselectlp
menuprintd:
	lw $t8 32896($a1)
	beq $t8 0x32154367 menuprinta
	lw $a0 1028($a1)
	jal menuselectframe
	addi $a1 $a1 384
	move $a0 $a2
	jal menuselectframe
	j menuselectlp
menuendselect:
	lw $ra ($sp)
	move $v0 $a1
	jr $ra
