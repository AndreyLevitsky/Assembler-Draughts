.text
.globl printmenusquare
printmenusquare:
	li $t2 32
	li $t3 32
printmenusquarelp:
	sw $a2 ($a1)
	addi $a1 $a1 4
	addi $t2 $t2 -1
	bnez $t2 printmenusquarelp
	addi $a1 $a1 896
	li $t2 32
	addi $t3 $t3 -1
	beqz $t3 printmenusquarecont
	j printmenusquarelp
printmenusquarecont:	
	addi $a1 $a1 -32768
	addi $a1 $a1 128
	move $v0 $a1
	jr $ra
