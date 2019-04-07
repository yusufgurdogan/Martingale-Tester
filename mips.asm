.data
enterbalance: .asciiz "Enter starting balance: "
enterhouseedge: .asciiz "Enter house edge (%):"
enterbetsize: .asciiz "Enter initial bet size:"
entergoal: .asciiz "Enter your goal (for doubling your money, enter 2):"
BetSizeGreater: .asciiz "Bet size can not be greater than your starting balance!\n"
.text
.globl main
main:

la $a0, enterbalance
li $v0, 4
syscall

li $v0, 5 # scanf balance
syscall 
move $a0, $v0

la $a0, enterhouseedge
li $v0, 4 # "Enter house edge (%):"
syscall

li $v0, 5 # scanf house edge
syscall 
move $a1, $v0

la $a0, enterbetsize
li $v0, 4 # "Enter initial bet size:"
syscall

li $v0, 5 # scanf bet size
syscall 
move $a2, $v0

bgt $a2, $a1, IfBetSizeGreater # If bet size is greater, jump to IfBetSizeGreater

la $a0, entergoal
li $v0, 4 # "Enter your goal (for doubling your money, enter 2):"
syscall

li $v0, 5 # scanf goal
syscall 
move $a3, $v0

li $v0, 10
syscall

IfBetSizeGreater:
la $a0, BetSizeGreater
li $v0, 4
syscall
li $v0, 10
syscall