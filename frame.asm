.text
.globl frame
frame:
	move $t0 $zero
	move $t1 $zero
sellp:	beqz $t1 allsellp
	beq $t1 31 allsellp
	sw $a0 ($a1)
	sw $a0 124($a1)
	addi $a1 $a1 1024
	addi $t1 $t1 1
	j sellp
allsellp:	
	sw $a0 ($a1)
	addi $a1 $a1 4
	addi $t0 $t0 1
	bne $t0 32 allsellp
	addi $t1 $t1 1
	beq $t1 32 selend
	move $t0 $zero
	addi $a1 $a1 896
	j sellp
selend:	
	addi $a1 $a1 -31872
	move $v0 $a1
	jr $ra
