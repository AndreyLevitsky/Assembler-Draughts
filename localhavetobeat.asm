.text
.globl localhavetobeat
localhavetobeat:
	move $v1 $zero
	move $t5 $zero
localhavetobeatlp:
	lw $t4 16448($a1)
	bne $t4 $a0 endlocalhavetobeatlp
	beq $a0 0x000000dd leftunotqueen
	beq $a0 0x0000aaaa leftunotqueen
	li $a3 100
	j leftu
leftunotqueen:
	li $a3 1
leftu:	
	move $t4 $a1
	j leftuproverka
leftulimitloop:
	addi $t4 $t4 -32896
leftuproverka:
	beq $t4 0x10010000 rightu
	beq $t4 0x10010080 rightu
	beq $t4 0x10010100 rightu
	beq $t4 0x10010180 rightu
	beq $t4 0x10010200 rightu
	beq $t4 0x10010280 rightu
	beq $t4 0x10010300 rightu
	beq $t4 0x10010380 rightu
	beq $t4 0x10018000 rightu
	beq $t4 0x10020000 rightu
	beq $t4 0x10028000 rightu
	beq $t4 0x10030000 rightu
	beq $t4 0x10038000 rightu
	beq $t4 0x10040000 rightu
	beq $t4 0x10048000 rightu
	beq $a1 $t4 leftulimitloop
	lw $t5 16448($t4)
	beq $t5 $a0 rightu
	beq $t5 $a2 rightu
	bne $t5 0xffffaaa0 leftunotempty
	addi $a3 $a3 -1
	beqz $a3 rightu
	j leftulimitloop
leftunotempty:
	lw $t5 -16448($t4)
	bne $t5 0xffffaaa0 rightu
	move $v1 $a1
	j endlocalhavetobeatlp
rightu:
	beq $a0 0x000000dd rightunotqueen
	beq $a0 0x0000aaaa rightunotqueen
	li $a3 100
	move $t4 $a1
	j rightuproverka
rightunotqueen:
	li $a3 1
	move $t4 $a1
	j rightuproverka
rightulimitloop:
	addi $t4 $t4 -32640
rightuproverka:
	beq $t4 0x10010000 leftd
	beq $t4 0x10010080 leftd
	beq $t4 0x10010100 leftd
	beq $t4 0x10010180 leftd
	beq $t4 0x10010200 leftd
	beq $t4 0x10010280 leftd
	beq $t4 0x10010300 leftd
	beq $t4 0x10010380 leftd
	beq $t4 0x10018380 leftd
	beq $t4 0x10020380 leftd
	beq $t4 0x10028380 leftd
	beq $t4 0x10030380 leftd
	beq $t4 0x10038380 leftd
	beq $t4 0x10040380 leftd
	beq $t4 0x10048380 leftd
	beq $t4 $a1 rightulimitloop
	lw $t5 16448($t4)
	beq $t5 $a0 leftd
	beq $t5 $a2 leftd
	bne $t5 0xffffaaa0 rightunotempty
	addi $a3 $a3 -1
	beqz $a3 leftd
	j rightulimitloop
rightunotempty:
	lw $t5 -16192($t4)
	bne $t5 0xffffaaa0 leftd
	move $v1 $a1
	j endlocalhavetobeatlp
leftd:
	beq $a0 0x000000dd leftdnotqueen
	beq $a0 0x0000aaaa leftdnotqueen
	li $a3 100
	move $t4 $a1
	j leftdproverka
leftdnotqueen:
	li $a3 1
	move $t4 $a1
	j leftdproverka
leftdlimitloop:
	addi $t4 $t4 32640
leftdproverka:
	beq $t4 0x10010000 rightd
	beq $t4 0x10018000 rightd
	beq $t4 0x10020000 rightd
	beq $t4 0x10028000 rightd
	beq $t4 0x10030000 rightd
	beq $t4 0x10038000 rightd
	beq $t4 0x10040000 rightd
	beq $t4 0x10048000 rightd
	beq $t4 0x10048000 rightd
	beq $t4 0x10048080 rightd
	beq $t4 0x10048100 rightd
	beq $t4 0x10048180 rightd
	beq $t4 0x10048200 rightd
	beq $t4 0x10048280 rightd
	beq $t4 0x10048300 rightd
	beq $t4 0x10048380 rightd
	beq $t4 $a1 leftdlimitloop
	lw $t5 16448($t4)
	beq $t5 $a0 rightd
	beq $t5 $a2 rightd
	bne $t5 0xffffaaa0 leftdnotempty
	addi $a3 $a3 -1
	beqz $a3 rightd
	j leftdlimitloop
leftdnotempty:
	lw $t5 49088($t4)
	bne $t5 0xffffaaa0 rightd
	move $v1 $a1
	j endlocalhavetobeatlp
rightd:
	beq $a0 0x000000dd rightdnotqueen
	beq $a0 0x0000aaaa rightdnotqueen
	li $a3 100
	move $t4 $a1
	j rightdproverka
rightdnotqueen:
	li $a3 1
	move $t4 $a1
	j rightdproverka
rightdlimitloop:
	addi $t4 $t4 32896
rightdproverka:
	beq $t4 0x10010380 endlocalhavetobeatlp
	beq $t4 0x10018380 endlocalhavetobeatlp
	beq $t4 0x10020380 endlocalhavetobeatlp
	beq $t4 0x10028380 endlocalhavetobeatlp
	beq $t4 0x10030380 endlocalhavetobeatlp
	beq $t4 0x10038380 endlocalhavetobeatlp
	beq $t4 0x10040380 endlocalhavetobeatlp
	beq $t4 0x10048380 endlocalhavetobeatlp
	beq $t4 0x10048000 endlocalhavetobeatlp
	beq $t4 0x10048080 endlocalhavetobeatlp
	beq $t4 0x10048100 endlocalhavetobeatlp
	beq $t4 0x10048180 endlocalhavetobeatlp
	beq $t4 0x10048200 endlocalhavetobeatlp
	beq $t4 0x10048280 endlocalhavetobeatlp
	beq $t4 0x10048300 endlocalhavetobeatlp
	beq $t4 0x10048380 endlocalhavetobeatlp
	beq $t4 $a1 rightdlimitloop
	lw $t5 16448($t4)
	beq $t5 $a0 endlocalhavetobeatlp
	beq $t5 $a2 endlocalhavetobeatlp
	bne $t5 0xffffaaa0 rightdnotempty
	addi $a3 $a3 -1
	beqz $a3 endlocalhavetobeatlp
	j rightdlimitloop
rightdnotempty:
	lw $t5 49344($t4)
	bne $t5 0xffffaaa0 endlocalhavetobeatlp
	move $v1 $a1
endlocalhavetobeatlp:
	jr $ra

