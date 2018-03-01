.text
.globl printcircle
printcircle:
	addi $a1 $a1 4112
	li $t0 144 #R**2
	li $t1 -12 #x1
	li $t2 12 #x2
	li $t3 -12 #y1
	li $t4 12 #y2
lp:
	mul $t5 $t1 $t1
	mul $t6 $t3 $t3
	add $t5 $t5 $t6
	bgt $t5 $t0 no
	sw $a0 ($a1)
no:	
	addi $a1 $a1 4
	addi $t1 $t1 1
	bne $t1 $t2 lp
	addi $a1 $a1 928 #896
	addi $t3 $t3 1
	beq $t3 $t4 end
	sub $t1 $t1 $t2
	sub $t1 $t1 $t2
	j lp
end:	
	addi $a1 $a1 -28560
	move $v0 $a1
	jr $ra
