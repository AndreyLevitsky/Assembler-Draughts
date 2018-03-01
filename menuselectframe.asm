.text
.globl menuselectframe
menuselectframe:
	move $t0 $zero
	move $t1 $zero
menuselectframesellp:	
	beqz $t1 menuselectframeallsellp
	beq $t1 63 menuselectframeallsellp
	sw $a0 ($a1)
	sw $a0 256($a1)
	addi $a1 $a1 1024
	addi $t1 $t1 1
	j menuselectframesellp
menuselectframeallsellp:	
	sw $a0 ($a1)
	addi $a1 $a1 4
	addi $t0 $t0 1
	bne $t0 64 menuselectframeallsellp
	addi $t1 $t1 1
	beq $t1 64 menuselectframeselend
	move $t0 $zero
	addi $a1 $a1 768
	j menuselectframesellp
menuselectframeselend:	
	addi $a1 $a1 -64768
	move $v0 $a1
	jr $ra