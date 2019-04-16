# Jake Tanda
# Assignment 3
# CSCI 311

# Reads a positive number from the user
# and prints all the prime numbers between 0 and that number.

.text
.globl main

main:
# Display prompt1
li $v0, 4 # pseudo-instruction; load the 'print string' syscall code
la $a0, prompt1 # pseudo-instruction; load the address of the string to print
syscall

li $v0, 5 # psuedo-instruction; read int from keyboard into $v0 (number x is number to test)
syscall

move $s0, $v0 # pseudo-instruction; move the first number from $v0 in $s0

# print the final prompt
li $v0, 4 
la $a0, prompt2
syscall

bge $s0, 2, printTwo # if n is greater than or equal to 2, print 2. (2 is a weird prime number since its even

loops:

# $s0 = n, $s1 = i, $s2 = j, $s3 = p
addi $s1, $0, 1  # set i = 1

for:
	addi $s1, $s1, 1    # add 1 to i
	bge $s1, $s0, exit # if i > n, jump to the exit
	addi $s3, $0, 0     # set p = 0
	addi $s2, $0, 2     # set j = 2

	for2:
		bne $s3, $0, next # branch if the loop is done (p = 1)
		div $s1, $s2       # divide i by j
		mfhi $t4           # move the remainder to $t4
		ble $t4, $0, setP  # branch if the remainder is 0
		contfor2:	
		addi $s2, $s2, 1    # add 1 to $s2
		blt $s2, $s1, for2 # if the number is less, then repeat the loop

	
	next:
	bne $s3, $0, for # if p = 0, go back to the first for
	li $v0, 1        # print out the number
	move $a0, $s1
	syscall
	
	li $v0, 4        # print out a space
	la $a0, space
	syscall
        j for

setP:
add $s3, $0, 1 # set p = 1
j contfor2 # continue to the for loop

printTwo:
li $v0, 4 # print out a 2
la $a0, two
syscall
j loops # jump to the for loops

exit: 
li $v0, 10 
syscall 


.data
prompt1:
 .asciiz "Enter a number: "
prompt2:
 .asciiz "Prime numbers up to inputted number: "
two:
 .asciiz "2 "
space:
 .asciiz " "
