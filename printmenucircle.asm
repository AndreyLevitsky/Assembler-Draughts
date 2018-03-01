.text
.globl printmenucircle
printmenucircle:
	li $t0 512 #R**2
	li $t1 -32 #x1
	li $t2 32 #x2
	li $t3 -32 #y1
	li $t4 32 #y2
printmenucirclelp:
	mul $t5 $t1 $t1
	mul $t6 $t3 $t3
	div $t6 $t6 2
	add $t5 $t5 $t6
	bgt $t5 $t0 printmenucircleno
	sw $a0 ($a1)
printmenucircleno:	
	addi $a1 $a1 4
	addi $t1 $t1 1
	bne $t1 $t2 printmenucirclelp
	addi $a1 $a1 768 #896
	addi $t3 $t3 1
	beq $t3 $t4 printmenucircleend
	sub $t1 $t1 $t2
	sub $t1 $t1 $t2
	j printmenucirclelp
printmenucircleend:	
	addi $a1 $a1 -65152
	move $v0 $a1
	jr $ra
