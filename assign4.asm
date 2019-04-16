# Jake Tanda
# Assignment 4
# CSCI 311

# function calling: saves the prime numbers from assignment 3 in an array
# and uses a function to print all of the numbers in the array.

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

addi $a0, $s0, 0   # pass the highest number as an argument
la $a1, array    # pass the address of the array as an argument in the array
jal prime_array    # call int prime_array(highestNumber, arrayAddress) : fills the array of prime numbers and returns the number of items in the array
addi $a0, $v0, 0   # pass the amount of items in the array
la $a1, array   # pass the address of the array as an argument in the array

jal print_array    # call void print_array() : prints the array

exit: 
li $v0, 10 
syscall 

prime_array:
addi $s0, $a0, 0
addi $v0, $0, 0    # set the current size of the array to 0
bge $s0, 2, addTwo # if n is greater than or equal to 2, add 2 to the array. (2 is a weird prime number since its even)

loops:
# $a0 = n
# $s1 = i
# $s2 = j
# $s3 = p
# $a1 = address of array
addi $s1, $0, 1  # set i = 1

for:
    addi $s1, $s1, 1       # add 1 to i
    bge $s1, $s0, func1End # if i > n, jump to the exit
    addi $s3, $0, 0        # set p = 0
    addi $s2, $0, 2        # set j = 2

    for2:
        bne $s3, $0, next   # branch if the loop is done (p = 1)
        div $s1, $s2        # divide i by j
        mfhi $t4            # move the remainder to $t4
        ble $t4, $0, setP   # branch if the remainder is 0
        addi $s2, $s2, 1    # add 1 to $s2
        blt $s2, $s1, for2  # if the number is less, then repeat the loop
next:
    # add number to array
    addi $t0, $v0, 0  # set $t0 to the array index adding the new number to
    sll $t0, $t0, 2   # $t0 = index * 4 (byte offset)
    add $t0, $t0, $a1 # $t0 = index added to the memory address 
    lw $t1, 2($t0)    # $t1 = array[index]
    addi $t1, $s1, 0  # $t1 = i
    sw $t1, 2($t0)    # array[index] = i
    addi $v0, $v0, 1  # increment the amount of items in the array
    j for             # jump back to the first for loop

setP:
add $s3, $0, 1   # set p = 1
j for      # continue to the for loop

addTwo:
la $t0, ($a1)     # $t0 = index added to the memory address 
addi $t1, $0, 2   # $t1 = i
sw $t1, 2($t0)    # array[index] = i
addi $v0, $v0, 1  # increment the amount of items in the array
j loops           # jump to the for loops

func1End:
jr $ra

print_array:
addi $s0, $0, 0  # $s0 = 0; looping variable
addi $s1, $a0, 0 # $s1 = $a0; number of items in the array
la $s2, ($a1)    # $s2 = address of $a1; starting address of the array.

printFor:
	bge $s0, $s1, func2End # if $s0 is greater than $s1, end the loop
	addi $t0, $s0, 0       # set $t0 = $s0 (index)
	sll $t0, $t0, 2        # shift 
	add $t0, $t0, $s2      # add the memory address to the shift
	lw $t1, 2($t0)         # load the stored integer into $t1
	
	li $v0, 1 # print the index
	move $a0, $s0
	syscall
	
	li $v0, 4 # print the colon
	la $a0, colon
	syscall
	
	li $v0, 1 # print the integer
	move $a0, $t1
	syscall
	
	addi $v0, $zero, 4  # print_string syscall
    	la $a0, newLine       # load address of the string
    	syscall
    	
    	addi $s0, $s0, 1
    	j printFor

func2End:
jr $ra

.data
prompt1:
 .asciiz "Enter a number: "
prompt2:
 .asciiz "Prime numbers up to inputted number: "
two:
 .asciiz "2"
colon:
 .asciiz ": "
newLine:
 .asciiz "\n"
array:
