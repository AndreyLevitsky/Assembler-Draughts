.data 0x10080200
a:	.asciiz "a"
w:	.asciiz "w"
s:	.asciiz "s"
d:	.asciiz "d"
r:	.asciiz "r"
q:	.asciiz "q"
.text
.globl select
select:
	sw $ra ($sp)
	sw $t8 -60($sp)
	lh $t2 a
	lh $t3 w
	lh $t4 s
	lh $t5 d
selectlp:		
	li $v0 12
	syscall
	beq $v0 0x0072 inputsymboltoescape #r
	beq $v0 0x0071 inputsymboltoescape #q
	j inputsymboltoescapecont
inputsymboltoescape:
	lw $ra ($sp)
	jr $ra
inputsymboltoescapecont:
	beq $t2 $v0 printa
	beq $t3 $v0 printw
	beq $t4 $v0 prints
	beq $t5 $v0 printd
	beq $v0 10 endselect
printa:
	beq $a1 0x10010000 printabad
	beq $a1 0x10018000 printabad
	beq $a1 0x10020000 printabad
	beq $a1 0x10028000 printabad
	beq $a1 0x10030000 printabad
	beq $a1 0x10038000 printabad
	beq $a1 0x10040000 printabad
	beq $a1 0x10048000 printabad
	j printagood
printabad:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 896
	j printabadcont
printagood:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 -128
printabadcont:
	move $a0 $a2
	jal frame
	j selectlp
printw:
	beq $a1 0x10010000 printwbad
	beq $a1 0x10010080 printwbad
	beq $a1 0x10010100 printwbad
	beq $a1 0x10010180 printwbad
	beq $a1 0x10010200 printwbad
	beq $a1 0x10010280 printwbad
	beq $a1 0x10010300 printwbad
	beq $a1 0x10010380 printwbad
	j printwgood
printwbad:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 229376
	j printwbadcont
printwgood:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 -32768
printwbadcont:
	move $a0 $a2
	jal frame
	j selectlp
prints:
	beq $a1 0x10048000 printsbad
	beq $a1 0x10048080 printsbad
	beq $a1 0x10048100 printsbad
	beq $a1 0x10048180 printsbad
	beq $a1 0x10048200 printsbad
	beq $a1 0x10048280 printsbad
	beq $a1 0x10048300 printsbad
	beq $a1 0x10048380 printsbad
	j printsgood
printsbad:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 -229376
	j printsbadcont
printsgood:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 32768
printsbadcont:
	move $a0 $a2
	jal frame
	j selectlp
printd:
	beq $a1 0x10010380 printdbad
	beq $a1 0x10018380 printdbad
	beq $a1 0x10020380 printdbad
	beq $a1 0x10028380 printdbad
	beq $a1 0x10030380 printdbad
	beq $a1 0x10038380 printdbad
	beq $a1 0x10040380 printdbad
	beq $a1 0x10048380 printdbad
	j printdgood
printdbad:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 -896
	j printdbadcont
printdgood:
	lw $a0 1028($a1)
	jal frame
	addi $a1 $a1 128
printdbadcont:
	move $a0 $a2
	jal frame
	j selectlp
endselect:
	lw $t8 -60($sp)
	lw $ra ($sp)
	move $v0 $a1
	jr $ra
