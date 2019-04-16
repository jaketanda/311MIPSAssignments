# Jake Tanda
# Towers of Hanoi
# CSCI 311

.text
.globl main

# Recursive towers of hanoi problem. 
# Has user input the number of discs and calculates the steps needed to complete the game.

main:
	addi $sp, $sp, -4 # make room in $sp
	sw $ra, 0($sp)    # store $ra 
	
	la $a0, nPrompt   # prompt the user for n
	li $v0, 4         
	syscall
	
	li $v0, 5         # take input from user
	syscall
	
	add $a0, $v0, $0  # load user input into argument 0
	li $a1, 1         # arg 1 = 1
	li $a2, 3         # arg 2 = 3
	jal hanoi         # call hanoi(n, 1, 2)
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	j exit

hanoi:
	# a0 = number of disks
	# a1 = start
	# a2 = end
	addi $sp, $sp, -20 # clears up space in the $sp
	sw $ra, 0($sp)  # store ra in the sp
	sw $s0, 4($sp)	# s0 = number of disks
	sw $s1, 8($sp)	# s1 = start
	sw $s2, 12($sp)	# s2 = end
	sw $s3, 16($sp) # s3 = mid
	
	add $s0, $a0, $0 # s0 = n
	add $s1, $a1, $0 # s1 = start
	add $s2, $a2, $0 # s2 = end
	
	addi $t0, $0, 1 # number of disks > 1
	bgt $s0, $t0, else # branch to else
	
	add $a0, $s1, $0 # set a0 to $s1
	add $a1, $s2, $0 # set a1 to $s2
	jal moveDisk     # jumps to move disk
	
	j end            # end of hanoi function
	
else:
	addi $s0, $s0, -1 # n = n-1
	addi $t0, $0, 6   # t0 = 6
	sub $t0, $t0, $s1 # subtract s1 from t0
	sub $s3, $t0, $s2 # sub s2 from t0
	
	add $a0, $s0, $0  # move s0 to a0
	add $a1, $s1, $0  # move s1 to a1
	add $a2, $s3, $0  # move s3 to a2
	jal hanoi         # recursive call back to hanoi
	
	add $a0, $s1, $0  # move s1 to a0
	add $a1, $s2, $0  # move s2 to a1
	jal moveDisk      # jump and link to movedisk
	
	add $a0, $s0, $0  # move s0 to a0
	add $a1, $s3, $0  # move s3 to a1
	add $a2, $s2, $0  # move s2 to a2
	jal hanoi         # recursive call back to hanoi
	
end:
	lw $s3, 16($sp)   # load from sp 16 to s3
	lw $s2, 12($sp)   # load from sp 12 to s2
	lw $s1, 8($sp)    # load from sp 8 to s1
	lw $s0, 4($sp)    # load from sp 4 to s0
	lw $ra, 0($sp)    # load from sp 0 to ra
	addi $sp, $sp, 20 # fills back up the sp
	jr $ra            # return to main

moveDisk:
	addi $sp, $sp, -4 # free up space in sp
	sw $ra, 0($sp)    # saves the ra in sp
	
	add $t0, $a0, $0 # t0 = from peg
	add $t1, $a1, $0 # t1 = final peg
	
	la $a0, movePrompt # prints the move promt
	li $v0, 4
	syscall
	
	add $a0, $t0, $0   # prints initial peg
	li $v0, 1
	syscall
	
	la $a0, toPrompt   # prints to
	li $v0, 4
	syscall
	
	add $a0, $t1, $0    # prints the final peg
	li $v0, 1
	syscall
	
	la $a0, elPrompt    # new line
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)      # loads return address
	addi $sp, $sp, 4    # fills back up sp
	jr $ra              # returns back to hanoi function
	
exit: 
li $v0, 10 # terminate the program
syscall 
 
.data
nPrompt: .asciiz "Enter the number of disks to be used: "
movePrompt: .asciiz "Move from "
toPrompt: .asciiz " to "
elPrompt: .asciiz "\n"
	
