.data

welcome: .asciiz "\nWelcome to Junjie's Euclidean Distance Calculator! (The final result number will be rounded up.)\n"
x1:	.asciiz "Please enter X1:"
x2:	.asciiz "Please enter X2:"
y1:	.asciiz "Please enter Y1:"
y2:  .asciiz "Please enter Y2:"
result:	.asciiz "Euclidean Distance is:"
another: .asciiz	"\nAnother calculation? (1-2, 1:yes, 2:no) "
errorOccur: .asciiz "Error\n"
anotherError:	.asciiz "Invalid input, please enter again (Input 1-2, 1:yes, 2:no) "


.text

main:
addi $v0, $0, 4
la $a0, welcome
syscall

	li $v0, 4
	la $a0, x1
	syscall

	li $v0, 5
	syscall
	addi		$t0,$v0,0

  li $v0, 4
  la $a0, y1
  syscall

  li $v0, 5
  syscall
  addi		$t2,$v0,0


	li $v0, 4
	la $a0, x2
	syscall

	li $v0, 5
	syscall
	addi		$t1,$v0,0


	li $v0, 4
	la $a0, y2
	syscall

	li $v0, 5
	syscall
	addi		$t3,$v0,0

distance:

	sub		$t0,$t0,$t2
	mul		$t0,$t0,$t0

	sub		$t1,$t1,$t3
	mul		$t1,$t1,$t1

	add		$t0,$t0,$t1
	addi		$a0,$t0,0
	jal		calculation
	addi		$t5,$v0,0


	li 		$v0, 4
	la 		$a0, result
	syscall

	addi		$a0,$t5,0
	li 		$v0, 1
	syscall

	jal anotherCalculation
	syscall



  loop:
  	mul   $t0,$v0,$v0
  	bge		$t0,$a0, end
  	addi		$v0,$v0,1
  	j		loop
  end:
	  addi $a0, $v0,0
  	jr		$ra

	calculation:
	  	add	$v0, $zero, $zero
			j loop


anotherCalculation:
li $v0, 4
la $a0, another

syscall
li $v0, 5
syscall

addi $s0, $v0,0

beq		$s0,1,jump
beq		$s0,2,exit
bne   $s0,1,retry
bne   $s0,2,retry

la $a0, anotherError
syscall
j retry

retry:
li 		$v0, 4
la 		$a0, anotherError
syscall

li $v0, 5

syscall
addi		$s0,$v0,0
beq		$s0,1,jump
beq		$s0,2,exit
bne   $s0,1,retry
bne   $s0,2,retry

la $a0, anotherError

syscall
j retry


jump:
j main
syscall

error:
addi $v0, $0, 4
la 		$a0, errorOccur
syscall
j anotherCalculation

exit:
li $v0, 10
syscall
