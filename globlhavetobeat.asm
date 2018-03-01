.text
.globl globlhavetobeat
globlhavetobeat:
	sw $ra -4($sp)
	sw $a2 -44($sp)
	move $v0 $zero
	move $v1 $zero
	la $a1 0x10010000
	li $t2 8
	li $t3 64
globlhavetobeatlp:	
	jal localhavetobeat
	beqz $v0 a
	bnez $v1 f 
	j c
a:	beqz $v1 c
	move $v0 $v1
c:	addi $t3 $t3 -1
	beqz $t3 f
	addi $t2 $t2 -1
	bnez $t2 co
	li $t2 8
	addi $a1 $a1 31744
co:	addi $a1 $a1 128
	lw $a2 16448($a1)
	beq $a2 $a0 equalcolour
	sub $a2 $a2 $a0
	abs $a2 $a2
	beq $a2 21845 equalcolour
	beq $a2 109 equalcolour
	j globlhavetobeatlp
equalcolour:
	lw $a0 16448($a1)
	beq $a0 0x000000dd nqb
	beq $a0 0x00000070 qb
	beq $a0 0x0000aaaa nqg
	beq $a0 0x00005555 qg
	j f
nqb:	li $a2 0x00000070
	j globlhavetobeatlpcont
qb:	li $a2 0x000000dd
	j globlhavetobeatlpcont
nqg:	li $a2 0x00005555
	j globlhavetobeatlpcont
qg:	li $a2 0x0000aaaa
globlhavetobeatlpcont:
	j globlhavetobeatlp
f:	
	lw $ra -4($sp)
	lw $a2 -44($sp)
	jr $ra
