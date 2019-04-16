# Jake Tanda
# CSCI 311
# Assignment 1-2

# This program prints out the maximum of four numbers.
# The two numbers are read through the keyboard.
# We sometimes use assembler pseudo-instructions; these are identified as such.
# Note how the assembler translates them into MIPS instructions.
.text
.globl main

main:
# Display prompt1
li $v0, 4 # pseudo-instruction; load the 'print string' syscall code
la $a0, prompt1 # pseudo-instruction; load the address of the string to print
syscall

li $v0, 5 # psuedo-instruction; read int from keyboard into $v0 (number x is number to test)
syscall

move $t0, $v0 # pseudo-instruction; move the first number from $v0 in $t0

# Display the prompt2 (string); similar to above
li $v0, 4
la $a0, prompt2
syscall

# read keyboard into $v0; similar to above
li $v0, 5 
syscall

# move the second number from $v0 in $t1
move $t1, $v0 

# Display the prompt3 (string); similar to above
li $v0, 4
la $a0, prompt3
syscall

# read keyboard into $v0; similar to above
li $v0, 5 
syscall

# move the third number from $v0 in $t2
move $t2, $v0 

# Display the prompt4 (string); similar to above
li $v0, 4
la $a0, prompt4
syscall

# read keyboard into $v0; similar to above
li $v0, 5 
syscall

# move the fourth number from $v0 in $t3
move $t3, $v0 

#Branch (jump) to L1 if $t1 is greater or equal to $t0
bge $t0, $t1, L1 # pseudo-instruction; see how it's translated

# largest number in $t0  
move $t0, $t1 	    

L1:
#Branch (jump) to L2 if $t2 is greater or equal to $t0
bge $t0, $t2, L2 # pseudo-instruction; see how it's translated

# largest number in $t0 
move $t0, $t2

L2:
#Branch (jump) to L3 if $t3 is greater or equal to $t0
bge $t0, $t3, L3 # pseudo-instruction; see how it's translated

# largest number in $t0 
move $t0, $t3

# print the string 'answer' 
L3: 
li $v0, 4 
la $a0, answer
syscall

# print integer function call 1 
# put the answer into $a0
li $v0, 1 
move $a0, $t0
syscall

#exit
end: li $v0, 10 
syscall 
 
.data
prompt1:
 .asciiz "Enter the first number: "
prompt2:
 .asciiz "Enter the second number: "
prompt3:
 .asciiz "Enter the third number: "
prompt4:
 .asciiz "Enter the fourth number: "
answer:
 .asciiz "The largest number is "
