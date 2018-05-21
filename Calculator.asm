.data

# variables

welcome: .asciiz "\nWelcome to Junjie's MIPS Calculator!\n"
Value1: .asciiz	"Input first number: "
Value2: .asciiz	"Input second number: "
operation:	.asciiz "Please input the operation (Input 1-4, 1:+, 2:-, 3:x, 4:\) :"
result:	.asciiz "The final result is: "
invalidInput:	.asciiz "Invalid input, please enter again (Input 1-4,1:+,2:-,3:x,4:\): "
another: .asciiz	"\nAnother calculation? (1-2, 1:yes, 2:no) "
errorOccur: .asciiz "Error\n"
anotherError:	.asciiz "Invalid input, please enter again (Input 1-2, 1:yes, 2:no) "


.text

main:
addi $v0, $0, 4
la $a0, welcome
syscall                     #print out welcome message

#get the first input number
li $v0, 4                   #system call code for printing string = 4
la $a0, Value1              #load the Value1 from the user input to a string

syscall                     #call the operating system to perform print operation


li $v0, 5                   #read in the number
syscall                     #waiting for the input

move $s0, $v0               #store the first input number to $s0

#get the second input number
li $v0, 4                   #system call code for printing string = 4
la $a0, Value2              #load the Value1 from the user input to a string

syscall                     #call the operating system to perform print operation

li $v0, 5                   #read in the number
syscall                     #waiting for the input
move $s1, $v0               #store the second input number to $s1

#get the operation input
li 		$v0, 4			          #system call code for printing string = 4
la 		$a0, operation	      #load address of string to be printed into $a0
syscall		           	      #call operating system to perform print operation

li $v0, 5                   #read in the number

syscall			                #system waits for input
move		$s2,$v0		          #store operator int in $s2


#Now we have to check what use input for the operation input
#We also check if the input is valid or invalid
beq		$s2,1,addition         #If user input is 1, then jump to addition
beq		$s2,2,subtraction      #If user input is 2, then jump to subtraction
beq		$s2,3,multiplication   #If user input is 3, then jump to multiplication
beq		$s2,4,division         #If user input is 4, then jump to division

bne   $s2,1,ope              #If user input other than 1, jump to ope
bne   $s2,2,ope              #If user input other than 2, jump to ope
bne   $s2,3,ope              #If user input other than 3, jump to ope
bne   $s2,4,ope              #If user input other than 4, jump to ope

ope:
li 		$v0, 4			           # system call code for printing string = 4
la 		$a0, invalidInput    	 # load address of string to be printed into $a0
syscall			                 # call operating system to perform print operation

li $v0, 5                    #read in the number

syscall			                 # system waits for input
move		$s2,$v0		           # store operator int in $s2
beq		$s2,1,addition         #If user input is 1, then jump to addition
beq		$s2,2,subtraction      #If user input is 2, then jump to subtraction
beq		$s2,3,multiplication   #If user input is 3, then jump to multiplication
beq		$s2,4,division         #If user input is 4, then jump to division
bne   $s2,1,ope              #If user input other than 1, jump to ope again
bne   $s2,2,ope              #If user input other than 2, jump to ope again
bne   $s2,3,ope              #If user input other than 3, jump to ope again
bne   $s2,4,ope              #If user input other than 4, jump to ope again

la $a0, invalidInput         #load address of string to be printed into $a0
syscall                      #call operating system to perform print operation
j ope                        #jump to ope

addition:
	add		$s2,$s0,$s1          #Addition
	j		print_result


subtraction:                 #Subtraction
	sub		$s2,$s0,$s1
	j		print_result


division:                    #Division
  beq     $s1,0,error
	div	   	$s0,$s1
	mflo		$s2
	j		print_result


multiplication:              #Multiplication
	multu 	$s0,$s1
	mflo		$s2
	j		print_result


#output
	print_result:
		li		$v0, 4		       	 # system call code for printing string = 4
		la 		$a0, result		     # load address of string to be printed into $a0
		syscall					         # call operating system to perform print operation

		li		$v0,1				       # system call code for printing integer = 1
		move		$a0,$s2
		syscall					         # call operating system to perform print operation




anotherCalculation:
li $v0, 4                    #system call code for printing string = 4
la $a0, another              #load the Value1 from the user input to a string

syscall                      #call the operating system to perform print operation
li $v0, 5                    #read in the number
syscall                      #waiting for the input

move $s0, $v0                #store the first input number to $s0

beq		$s0,1,jump             #If user input is 1, then jump back to main
beq		$s0,2,exit             #If user input is 2, then exit the program
bne   $s0,1,retry            #check if the input is valid or invalid
bne   $s0,2,retry            #check if the input is valid or invalid

la $a0, anotherError         #load address of string to be printed into $a0
syscall                      #call operating system to perform print operation
j retry                      #jump tp retry

retry:
li 		$v0, 4		          	 #system call code for printing string = 4
la 		$a0, anotherError	     #load address of string to be printed into $a0
syscall			                 #call operating system to perform print operation

li $v0, 5                    #read in the number

syscall			                 #system waits for input
move		$s0,$v0		           #store operator int in $s2
beq		$s0,1,jump             #If user input is 1, then jump back to main
beq		$s0,2,exit             #If user input is 2, then exit the program
bne   $s0,1,retry            #If user input is not 1, jump to retry
bne   $s0,2,retry            #If user input is not 2, jump to retry

la $a0, anotherError         #load address of string to be printed into $a0

syscall                      #call operating system to perform print operation
j retry                      #jump tp retry


jump:
j main                       #jump to main if user input is 1
syscall

error:
addi $v0, $0, 4
la 		$a0, errorOccur		     # load address of string to be printed into $a0
syscall					             # call operating system to perform print operation
j anotherCalculation

exit:                        #exit the program if user input is 2
li $v0, 10		               #exits program
syscall
