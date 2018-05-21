.data

welcome: .asciiz "\nWelcome to Junjie's Hamming Distance Calculator! You're only allow to input length of string up to two.\n"
firstString:	.asciiz "\Please enter the first number: "
secondString:  	.asciiz "\nPlease enter the second number: "
result:	.asciiz "\nThe Hamming distance is:"
fString:		.asciiz "  "
sString:		.asciiz "  "
another: .asciiz	"\nAnother calculation? (1-2, 1:yes, 2:no) "
errorOutput:   .asciiz "Invalid operation input, please enter new input (1:Yes, 2:No) : "

	.text

main:
 addi $v0, $0, 4
 la $a0, welcome
 syscall

 li	$t5,0
 li $t6,0


	li $v0, 4
	la $a0, firstString
	syscall


	la $a0,fString
	li $a1,3
	li $v0, 8
	syscall

	li $v0, 4
	la $a0, secondString
	syscall


	la $a0,sString
	li $a1,3
	li $v0, 8
	syscall

	la	$t0,fString
	la	$t1,sString
	lbu	$t2,0($t0)
	lbu	$t3,0($t1)
	beq	$t2,$t3,equal1
  bne $t2,$t3,notEqualFirstOne

notEqualFirstOne:
add	$t5,1

equal1:
	lbu	$t2,1($t0)
	lbu	$t3,1($t1)
	beq	$t2,$t3,printResult
  bne $t2,$t3, notEqualSecondOne

notEqualSecondOne:
	add	$t6,1


printResult:
	li 		$v0, 4
	la 		$a0, result
	syscall

  add $t5,$t5,$t6
	addi		$a0,$t5,0
	li 		$v0, 1
	syscall

li         $v0, 4
la         $a0, another
syscall

li         $v0, 5
syscall
addi        $s3,$v0,0

beq        $s3,1, main
beq        $s3,2, exit
bne        $s3,1, error
bne        $s3,2, error
error:
li         $v0, 4
la         $a0, errorOutput
syscall

li         $v0, 5
syscall

addi        $s3,$v0,0

beq        $s3,1, main
beq        $s3,2, exit
bne        $s3,1, error
bne        $s3,2, error


exit:
li $v0, 10
syscall
