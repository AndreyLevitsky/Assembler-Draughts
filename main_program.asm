.macro Nice
	sw $a0 ($sp)
	la $a0 nice
	li $v0 4
	syscall
	lw $a0 ($sp)
.end_macro
.macro WhoseTurn
	sw $a0 ($sp)
	beq $t7 1 greenturn
	la $a0 blueturntext
	li $v0 4
	syscall
	j finturn
greenturn:
	la $a0 greenturntext
	li $v0 4
	syscall
finturn:
	lw $a0 ($sp)
.end_macro
.macro Who_beat
	sw $t8 -72($sp)
	sw $t9 -76($sp)
	lw $t8 -64($sp)
	lw $t9 -68($sp)
	beq $t7 1 greenbeat
	addi $t9 $t9 -1
	j bluebeatcont
greenbeat:
	addi $t8 $t8 -1
bluebeatcont:
	beqz $t8 bluewins
	beqz $t9 greenwins
	j nobodywins
bluewins:
	la $a0 greenwinstext
	li $v0 4
	syscall
	li $v0 10
	syscall
greenwins:
	la $a0 bluewinstext
	li $v0 4
	syscall
	li $v0 10
	syscall
nobodywins:
	sw $t8 -64($sp)
	sw $t9 -68($sp)
	lw $t8 -72($sp)
	lw $t9 -76($sp)
.end_macro
.data 0x10080000
light:	.word 0xffffdaa0
dark:	.word 0xffffaaa0
blue:	.word 0x000000dd
bluequeen:	.word 0x00000070
green:	.word 0x0000aaaa
greenqueen:	.word 0x00005555
black:	.word 0x0000000b
nice:   .asciiz "Nice choice!"
greenturntext:	.asciiz "Green's turn!"
blueturntext:	.asciiz "Blue's turn!"
bluewinstext:	.asciiz "Blue wins!!!"
greenwinstext:	.asciiz "Green wins!!!"
Enter_the_game_text:	.asciiz "You take the blue pill, the story ends... You wake up in your bed and believe whatever you want to believe.\nYou take the red pill, you stay in Wonderland... And I show you how deep the rabbit hole goes..."
.text
nachalo_nachal:
	la $a0 Enter_the_game_text
	li $v0 4
	syscall
	li $a0 '\n'
	li $v0 11
	syscall
	jal menufon
	bnez $v0 prepare1
	li $v0 10
	syscall
prepare1:
	lw $t0 light #light
	lw $t1 dark #dark
	la $a1 0x10010000
	move $a0 $t0
	li $t6 1
	li $t4 8
	li $t5 64
loopsq:	bgtz $t6 lpsq
	move $a0 $t1
lpsq:	
	jal printsquare
	move $a1 $v0
	mul $t6 $t6 -1
	addi $t5 $t5 -1
	beqz $t5 prepare2
	addi $t4 $t4 -1
	move $a0 $t0
	bnez $t4 loopsq
	mul $t6 $t6 -1
	addi $a1 $a1 31744#32768
	li $t4 8
	j loopsq
prepare2:
	li $t7 24
	li $t8 4
	li $t9 1
	lw $t0 blue #blue
	la $a1 0x10010000
	move $a0 $t0
with1:	
	addi $a1 $a1 128
without1:	
	jal printcircle
	addi $t7 $t7 -1
	beq $t7 12 space
	addi $t8 $t8 -1
	bnez $t8 with1
	li $t8 4
	addi $a1 $a1 31744
	bgtz $t9 no1
	addi $a1 $a1 128
	mul $t9 $t9 -1
	j with1
no1:	
	mul $t9 $t9 -1
	j without1
space:	
	addi $a1 $a1 97280
	lw $a0 green
	mul $t9 $t9 -1
	li $t8 4
	j without2
with2:	
	addi $a1 $a1 128
without2:	
	jal printcircle
	addi $t7 $t7 -1
	beqz $t7 prepare3
	addi $t8 $t8 -1
	bnez $t8 with2
	li $t8 4
	addi $a1 $a1 31744
	bgtz $t9 no2
	addi $a1 $a1 128
	mul $t9 $t9 -1
	j with2
no2:	
	mul $t9 $t9 -1
	j without2
prepare3:	
	la $a1 0x10010000
	lw $a0 black
	jal frame
start:
	li $t8 12 #green
	li $t9 12 #blue
	sw $t8 -64($sp)
	sw $t9 -68($sp)
	li $t7 1
	move $a1 $v0
	WhoseTurn
main_loop:
	lw $a2 black
	jal select
	beq $v0 0x0072 prepare1 #r
	beq $v0 0x0071 nachalo_nachal #q
	move $a1 $v0
selectsq:	
	lw $t9 16448($a1)
	beq $t7 1 selgreen
	beq $t7 -1 selblue
	j main_loop
selgreen:	
	beq $t9 0x0000aaaa selgreenaccept
	beq $t9 0x00005555 selgreenaccept
	j main_loop
selgreenaccept:
	move $t8 $a1
	move $a0 $t9
	sw $t9 -12($sp)
	jal globlhavetobeat
	move $t9 $v0
	beqz $v0 havenottog
	beqz $v1 haveto1g
haveto2g:
	beq $t8 $v0 havenottog
	beq $t8 $v1 havenottog
	move $a1 $t8
	j main_loop
haveto1g:
	beq $t8 $v0 havenottog
	move $a1 $t8
	j main_loop
havenottog:
	move $a1 $t8
	sw $t8 -8($sp)
	Nice
nostepg:	
	jal select
	beq $v0 0x0072 prepare1 #r
	beq $v0 0x0071 nachalo_nachal #q
	move $a1 $v0
	lw $t1 16448($a1)
	bne $t1 0xffffaaa0 main_loop
	sub $t8 $t8 $a1
	bnez $t9 onlybeatg
	lw $t9 -12($sp)
	beq $t9 0x000000dd stepnotqueeng
	beq $t9 0x0000aaaa stepnotqueeng
	beq $t8 -65280 step
	beq $t8 -97920 step
	beq $t8 -103560 step
	beq $t8 -163200 step
	beq $t8 -195840 step
	beq $t8 -228480 step
	beq $t8 -65792 step
	beq $t8 -98688 step
	beq $t8 -131584 step
	beq $t8 -164480 step
	beq $t8 -197376 step
	beq $t8 -230272 step
	beq $t8 32640 step
	beq $t8 -32640 step
	beq $t8 65280 step
	beq $t8 97920 step
	beq $t8 103560 step
	beq $t8 163200 step
	beq $t8 195840 step
	beq $t8 228480 step
	beq $t8 32896 step
	beq $t8 65792 step
	beq $t8 -32896 step
	beq $t8 98688 step
	beq $t8 131584 step
	beq $t8 164480 step
	beq $t8 197376 step
	beq $t8 230272 step
stepnotqueeng:
	beq $t8 32640 step
	beq $t8 32896 step
	j main_loop
onlybeatg:
	sw $a2 -44($sp)
	lw $t9 -12($sp)
	beq $t9 0x000000dd onlybeatgnqb
	beq $t9 0x00000070 onlybeatgqb
	beq $t9 0x0000aaaa onlybeatgnqg
	beq $t9 0x00005555 onlybeatgqg
	j main_loop
onlybeatgnqb:	
	li $a2 0x00000070
	j onlybeatgcont
onlybeatgqb:	
	li $a2 0x000000dd
	j onlybeatgcont
onlybeatgnqg:	
	li $a2 0x00005555
	j onlybeatgcont
onlybeatgqg:	
	li $a2 0x0000aaaa
onlybeatgcont:
	beq $t9 0x000000dd beatnotqueeng
	beq $t9 0x0000aaaa beatnotqueeng
	li $a3 30
	beq $t8 65280 rightbeatu
	beq $t8 97920 rightbeatu
	beq $t8 130560 rightbeatu
	beq $t8 163200 rightbeatu
	beq $t8 195840 rightbeatu
	beq $t8 228480 rightbeatu
	beq $t8 65792 leftbeatu
	beq $t8 98688 leftbeatu
	beq $t8 131584 leftbeatu
	beq $t8 164480 leftbeatu
	beq $t8 197376 leftbeatu
	beq $t8 230272 leftbeatu
	beq $t8 -65792 rightbeatd
	beq $t8 -98688 rightbeatd
	beq $t8 -131584 rightbeatd
	beq $t8 -164480 rightbeatd
	beq $t8 -197376 rightbeatd
	beq $t8 -230272 rightbeatd
	beq $t8 -65280 leftbeatd
	beq $t8 -97920 leftbeatd
	beq $t8 -130560 leftbeatd
	beq $t8 -163200 leftbeatd
	beq $t8 -195840 leftbeatd
	beq $t8 -228480 leftbeatd
	j main_loop
beatnotqueeng:
	li $a3 2
	beq $t8 65280 rightbeatu
	beq $t8 65792 leftbeatu
	beq $t8 -65792 rightbeatd
	beq $t8 -65280 leftbeatd
	j main_loop
selblue:
	beq $t9 0x000000dd selblueaccept
	beq $t9 0x00000070 selblueaccept
	j main_loop
selblueaccept:
	move $t8 $a1
	move $a0 $t9
	sw $t9 -12($sp)
	jal globlhavetobeat
	move $t9 $v0
	beqz $v0 havenottob
	beqz $v1 haveto1b
haveto2b:
	beq $t8 $v0 havenottob
	beq $t8 $v1 havenottob
	move $a1 $t8
	j main_loop
haveto1b:
	beq $t8 $v0 havenottob
	move $a1 $t8
	j main_loop
havenottob:
	move $a1 $t8
	sw $t8 -8($sp)
	Nice
nostepb:	
	jal select
	beq $v0 0x0072 prepare1 #r
	beq $v0 0x0071 nachalo_nachal #q
	move $a1 $v0
	lw $t1 16448($a1)
	bne $t1 0xffffaaa0 main_loop
	sub $t8 $t8 $a1
	bnez $t9 onlybeatb
	lw $t9 -12($sp)
	beq $t9 0x000000dd stepnotqueenb
	beq $t9 0x0000aaaa stepnotqueenb
	beq $t8 -65280 step
	beq $t8 -97920 step
	beq $t8 -103560 step
	beq $t8 -163200 step
	beq $t8 -195840 step
	beq $t8 -228480 step
	beq $t8 -65792 step
	beq $t8 -98688 step
	beq $t8 -131584 step
	beq $t8 -164480 step
	beq $t8 -197376 step
	beq $t8 -230272 step
	beq $t8 32640 step
	beq $t8 -32640 step
	beq $t8 65280 step
	beq $t8 97920 step
	beq $t8 103560 step
	beq $t8 163200 step
	beq $t8 195840 step
	beq $t8 228480 step
	beq $t8 32896 step
	beq $t8 -32896 step
	beq $t8 65792 step
	beq $t8 98688 step
	beq $t8 131584 step
	beq $t8 164480 step
	beq $t8 197376 step
	beq $t8 230272 step
stepnotqueenb:
	beq $t8 -32640 step
	beq $t8 -32896 step
	j main_loop
onlybeatb:
	sw $a2 -44($sp)
	lw $t9 -12($sp)
	beq $t9 0x000000dd onlybeatbnqb
	beq $t9 0x00000070 onlybeatbqb
	beq $t9 0x0000aaaa onlybeatbnqg
	beq $t9 0x00005555 onlybeatbqg
	j main_loop
onlybeatbnqb:	
	li $a2 0x00000070
	j onlybeatbcont
onlybeatbqb:	
	li $a2 0x000000dd
	j onlybeatbcont
onlybeatbnqg:	
	li $a2 0x00005555
	j onlybeatbcont
onlybeatbqg:	
	li $a2 0x0000aaaa
onlybeatbcont:
	beq $t9 0x000000dd beatnotqueenb
	beq $t9 0x0000aaaa beatnotqueenb
	li $a3 30
	beq $t8 65280 rightbeatu
	beq $t8 97920 rightbeatu
	beq $t8 130560 rightbeatu
	beq $t8 163200 rightbeatu
	beq $t8 195840 rightbeatu
	beq $t8 228480 rightbeatu
	beq $t8 65792 leftbeatu
	beq $t8 98688 leftbeatu
	beq $t8 131584 leftbeatu
	beq $t8 164480 leftbeatu
	beq $t8 197376 leftbeatu
	beq $t8 230272 leftbeatu
	beq $t8 -65792 rightbeatd
	beq $t8 -98688 rightbeatd
	beq $t8 -131584 rightbeatd
	beq $t8 -164480 rightbeatd
	beq $t8 -197376 rightbeatd
	beq $t8 -230272 rightbeatd
	beq $t8 -65280 leftbeatd
	beq $t8 -97920 leftbeatd
	beq $t8 -130560 leftbeatd
	beq $t8 -163200 leftbeatd
	beq $t8 -195840 leftbeatd
	beq $t8 -228480 leftbeatd
	j main_loop
beatnotqueenb:
	li $a3 2
	beq $t8 65280 rightbeatu
	beq $t8 65792 leftbeatu
	beq $t8 -65792 rightbeatd
	beq $t8 -65280 leftbeatd
	j main_loop
step:
	lw $a0 dark
	sw $a1 ($sp)
	lw $t9 -12($sp)
	lw $t8 -8($sp)
	move $a1 $t8
	jal printsquare
	move $a1 $v0
	addi $a1 $a1 -128
	move $a0 $t9
	lw $a1 ($sp)
	beq $t9 0x000000dd maybestepbluequeen
	beq $a1 0x10010000 stepgreenqueen
	beq $a1 0x10010080 stepgreenqueen
	beq $a1 0x10010100 stepgreenqueen
	beq $a1 0x10010180 stepgreenqueen
	beq $a1 0x10010200 stepgreenqueen
	beq $a1 0x10010280 stepgreenqueen
	beq $a1 0x10010300 stepgreenqueen
	beq $a1 0x10010380 stepgreenqueen
	j stepgreenqueencon
maybestepbluequeen:
	beq $a1 0x10048000 stepbluequeen
	beq $a1 0x10048080 stepbluequeen
	beq $a1 0x10048100 stepbluequeen
	beq $a1 0x10048180 stepbluequeen
	beq $a1 0x10048200 stepbluequeen
	beq $a1 0x10048280 stepbluequeen
	beq $a1 0x10048300 stepbluequeen
	beq $a1 0x10048380 stepbluequeen
	j stepgreenqueencon
stepgreenqueen:
	li $a0 0x00005555
	j stepgreenqueencon
stepbluequeen:
	li $a0 0x00000070
stepgreenqueencon:
	jal printcircle
	move $a1 $v0
	lw $a0 dark
	addi $a1 $a1 -128
	jal frame
	move $a1 $v0
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
leftbeatu:	
	sw $t5 -28($sp)
	sw $t4 -32($sp)
	li $t4 1
	sw $a1 ($sp)
	lw $t8 -8($sp)
	lw $t9 -12($sp)
leftbeatuloop:
	addi $t8 $t8 -32896
	addi $a3 $a3 -1
	beq $t8 $a1 leftbeatuendproverka
	lw $t5 16448($t8)
	beq $t5 $t9 main_loop
	beq $t5 $a2 main_loop
	beq $t5 0xffffaaa0 leftbeatunotmeet
	addi $t4 $t4 -1
leftbeatunotmeet:
	j leftbeatuloop
leftbeatuendproverka:
	bltz $a3 main_loop
	lw $t5 16448($t8)
	bne $t5 0xffffaaa0 main_loop
	bnez $t4 main_loop
	lw $t5 -28($sp)
	lw $t4 -32($sp)
	move $t8 $a1
	lw $a1 -8($sp)
leftbeatugood:	
	beq $t8 $a1 leftbeatugoodendbeat
	lw $a0 dark
	jal printsquare
	move $a1 $v0
	addi $a1 $a1 -128
	addi $a1 $a1 -32896
	j leftbeatugood
leftbeatugoodendbeat:
	Who_beat
	move $a0 $t9
	lw $a1 ($sp)
	jal printcircle
	move $a1 $v0
	lw $a0 dark
	addi $a1 $a1 -128
	lw $a2 -44($sp)
	jal frame
	move $a1 $v0
	sw $a1 ($sp)
	move $a0 $t9
	jal globlhavetobeat
	lw $a1 ($sp)
	beqz $v0 leftbeatuhavenotto
	beqz $v1 leftbeatuhaveto1
leftbeatuhaveto2:
	beq $a1 $v0 main_loop
	beq $a1 $v1 main_loop
	j leftbeatuhavenotto
leftbeatuhaveto1:
	beq $a1 $v0 main_loop
leftbeatuhavenotto:
	beq $t9 0x000000dd leftbeatumaybenewqueenblue
	beq $a1 0x10010000 stepgreenqueen
	beq $a1 0x10010080 stepgreenqueen
	beq $a1 0x10010100 stepgreenqueen
	beq $a1 0x10010180 stepgreenqueen
	beq $a1 0x10010200 stepgreenqueen
	beq $a1 0x10010280 stepgreenqueen
	beq $a1 0x10010300 stepgreenqueen
	beq $a1 0x10010380 stepgreenqueen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
leftbeatumaybenewqueenblue:
	beq $a1 0x10048000 stepbluequeen
	beq $a1 0x10048080 stepbluequeen
	beq $a1 0x10048100 stepbluequeen
	beq $a1 0x10048180 stepbluequeen
	beq $a1 0x10048200 stepbluequeen
	beq $a1 0x10048280 stepbluequeen
	beq $a1 0x10048300 stepbluequeen
	beq $a1 0x10048380 stepbluequeen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
rightbeatu:	
	sw $t5 -28($sp)
	sw $t4 -32($sp)
	li $t4 1
	sw $a1 ($sp)
	lw $t8 -8($sp)
	lw $t9 -12($sp)
rightbeatuloop:
	addi $t8 $t8 -32640
	addi $a3 $a3 -1
	beq $t8 $a1 rightbeatuendproverka
	lw $t5 16448($t8)
	beq $t5 $t9 main_loop
	beq $t5 $a2 main_loop
	beq $t5 0xffffaaa0 rightbeatunotmeet
	addi $t4 $t4 -1
rightbeatunotmeet:
	j rightbeatuloop
rightbeatuendproverka:
	bltz $a3 main_loop
	lw $t5 16448($t8)
	bne $t5 0xffffaaa0 main_loop
	bnez $t4 main_loop
	lw $t5 -28($sp)
	lw $t4 -32($sp)
	move $t8 $a1
	lw $a1 -8($sp)
rightbeatugood:	
	beq $t8 $a1 rightbeatugoodendbeat
	lw $a0 dark
	jal printsquare
	move $a1 $v0
	addi $a1 $a1 -128
	addi $a1 $a1 -32640
	j rightbeatugood
rightbeatugoodendbeat:
	Who_beat
	move $a0 $t9
	lw $a1 ($sp)
	jal printcircle
	move $a1 $v0
	lw $a0 dark
	addi $a1 $a1 -128
	lw $a2 -44($sp)
	jal frame
	move $a1 $v0
	sw $a1 ($sp)
	move $a0 $t9
	jal globlhavetobeat
	lw $a1 ($sp)
	beqz $v0 rightbeatuhavenotto
	beqz $v1 rightbeatuhaveto1
rightbeatuhaveto2:
	beq $a1 $v0 main_loop
	beq $a1 $v1 main_loop
	j rightbeatuhavenotto
rightbeatuhaveto1:
	beq $a1 $v0 main_loop
rightbeatuhavenotto:
	beq $t9 0x000000dd rightbeatumaybenewqueenblue
	beq $a1 0x10010000 stepgreenqueen
	beq $a1 0x10010080 stepgreenqueen
	beq $a1 0x10010100 stepgreenqueen
	beq $a1 0x10010180 stepgreenqueen
	beq $a1 0x10010200 stepgreenqueen
	beq $a1 0x10010280 stepgreenqueen
	beq $a1 0x10010300 stepgreenqueen
	beq $a1 0x10010380 stepgreenqueen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
rightbeatumaybenewqueenblue:
	beq $a1 0x10048000 stepbluequeen
	beq $a1 0x10048080 stepbluequeen
	beq $a1 0x10048100 stepbluequeen
	beq $a1 0x10048180 stepbluequeen
	beq $a1 0x10048200 stepbluequeen
	beq $a1 0x10048280 stepbluequeen
	beq $a1 0x10048300 stepbluequeen
	beq $a1 0x10048380 stepbluequeen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
leftbeatd:	
	sw $t5 -28($sp)
	sw $t4 -32($sp)
	li $t4 1
	sw $a1 ($sp)
	lw $t8 -8($sp)
	lw $t9 -12($sp)
leftbeatdloop:
	addi $t8 $t8 32640
	addi $a3 $a3 -1
	beq $t8 $a1 leftbeatdendproverka
	lw $t5 16448($t8)
	beq $t5 $t9 main_loop
	beq $t5 $a2 main_loop
	beq $t5 0xffffaaa0 leftbeatdnotmeet
	addi $t4 $t4 -1
leftbeatdnotmeet:
	j leftbeatdloop
leftbeatdendproverka:
	bltz $a3 main_loop
	lw $t5 16448($t8)
	bne $t5 0xffffaaa0 main_loop
	bnez $t4 main_loop
	lw $t5 -28($sp)
	lw $t4 -32($sp)
	move $t8 $a1
	lw $a1 -8($sp)
leftbeatdgood:	
	beq $t8 $a1 leftbeatdgoodendbeat
	lw $a0 dark
	jal printsquare
	move $a1 $v0
	addi $a1 $a1 -128
	addi $a1 $a1 32640
	j leftbeatdgood
leftbeatdgoodendbeat:
	Who_beat
	move $a0 $t9
	lw $a1 ($sp)
	jal printcircle
	move $a1 $v0
	lw $a0 dark
	addi $a1 $a1 -128
	lw $a2 -44($sp)
	jal frame
	move $a1 $v0
	sw $a1 ($sp)
	move $a0 $t9
	jal globlhavetobeat
	lw $a1 ($sp)
	beqz $v0 leftbeatdhavenotto
	beqz $v1 leftbeatdhaveto1
leftbeatdhaveto2:
	beq $a1 $v0 main_loop
	beq $a1 $v1 main_loop
	j leftbeatdhavenotto
leftbeatdhaveto1:
	beq $a1 $v0 main_loop
leftbeatdhavenotto:
	beq $t9 0x000000dd leftbeatdmaybenewqueenblue
	beq $a1 0x10010000 stepgreenqueen
	beq $a1 0x10010080 stepgreenqueen
	beq $a1 0x10010100 stepgreenqueen
	beq $a1 0x10010180 stepgreenqueen
	beq $a1 0x10010200 stepgreenqueen
	beq $a1 0x10010280 stepgreenqueen
	beq $a1 0x10010300 stepgreenqueen
	beq $a1 0x10010380 stepgreenqueen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
leftbeatdmaybenewqueenblue:
	beq $a1 0x10048000 stepbluequeen
	beq $a1 0x10048080 stepbluequeen
	beq $a1 0x10048100 stepbluequeen
	beq $a1 0x10048180 stepbluequeen
	beq $a1 0x10048200 stepbluequeen
	beq $a1 0x10048280 stepbluequeen
	beq $a1 0x10048300 stepbluequeen
	beq $a1 0x10048380 stepbluequeen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
rightbeatd:	
	sw $t5 -28($sp)
	sw $t4 -32($sp)
	li $t4 1
	sw $a1 ($sp)
	lw $t8 -8($sp)
	lw $t9 -12($sp)
rightbeatdloop:
	addi $t8 $t8 32896
	addi $a3 $a3 -1
	beq $t8 $a1 rightbeatdendproverka
	lw $t5 16448($t8)
	beq $t5 $t9 main_loop
	beq $t5 $a2 main_loop
	beq $t5 0xffffaaa0 rightbeatdnotmeet
	addi $t4 $t4 -1
rightbeatdnotmeet:
	j rightbeatdloop
rightbeatdendproverka:
	bltz $a3 main_loop
	lw $t5 16448($t8)
	bne $t5 0xffffaaa0 main_loop
	bnez $t4 main_loop
	lw $t5 -28($sp)
	lw $t4 -32($sp)
	move $t8 $a1
	lw $a1 -8($sp)
rightbeatdgood:	
	beq $t8 $a1 rightbeatdgoodendbeat
	lw $a0 dark
	jal printsquare
	move $a1 $v0
	addi $a1 $a1 -128
	addi $a1 $a1 32896
	j rightbeatdgood
rightbeatdgoodendbeat:
	Who_beat
	move $a0 $t9
	lw $a1 ($sp)
	jal printcircle
	move $a1 $v0
	lw $a0 dark
	addi $a1 $a1 -128
	lw $a2 -44($sp)
	jal frame
	move $a1 $v0
	sw $a1 ($sp)
	move $a0 $t9
	jal globlhavetobeat
	lw $a1 ($sp)
	beqz $v0 rightbeatdhavenotto
	beqz $v1 rightbeatdhaveto1
rightbeatdhaveto2:
	beq $a1 $v0 main_loop
	beq $a1 $v1 main_loop
	j rightbeatdhavenotto
rightbeatdhaveto1:
	beq $a1 $v0 main_loop
rightbeatdhavenotto:
	beq $t9 0x000000dd rightbeatdmaybenewqueenblue
	beq $a1 0x10010000 stepgreenqueen
	beq $a1 0x10010080 stepgreenqueen
	beq $a1 0x10010100 stepgreenqueen
	beq $a1 0x10010180 stepgreenqueen
	beq $a1 0x10010200 stepgreenqueen
	beq $a1 0x10010280 stepgreenqueen
	beq $a1 0x10010300 stepgreenqueen
	beq $a1 0x10010380 stepgreenqueen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
rightbeatdmaybenewqueenblue:
	beq $a1 0x10048000 stepbluequeen
	beq $a1 0x10048080 stepbluequeen
	beq $a1 0x10048100 stepbluequeen
	beq $a1 0x10048180 stepbluequeen
	beq $a1 0x10048200 stepbluequeen
	beq $a1 0x10048280 stepbluequeen
	beq $a1 0x10048300 stepbluequeen
	beq $a1 0x10048380 stepbluequeen
	mul $t7 $t7 -1
	WhoseTurn
	j main_loop
