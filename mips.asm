.data
enterbalance: .asciiz "Enter starting balance: "
enterhouseedge: .asciiz "Enter house edge (%):"
enterbetsize: .asciiz "Enter initial bet size:"
entergoal: .asciiz "Enter your goal (for doubling your money, enter 2):"
BetSizeGreater: .asciiz "Bet size can not be greater than your starting balance!\n"
Win: .asciiz "WIN!\n"
Lose: .asciiz "LOSE!\n"
betsize: .asciiz "bet size: "
balance: .asciiz "balance: "
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

bgt $a2, $a0, IfBetSizeGreater # If bet size is greater, jump to IfBetSizeGreater

la $a0, entergoal
li $v0, 4 # "Enter your goal (for doubling your money, enter 2):"
syscall

li $v0, 5 # scanf goal
syscall 
move $a3, $v0

j loop
loop:
li $a1, 100 # random number interval is 0-100, inclusive
li $v0, 42 # generate random number
syscall
li $v0, 1
syscall
bgt $a0, 50, greaterThan 
#lessThan: 
la $a0, Win
li $v0, 4 # "WIN!"
syscall
j loop

greaterThan:
la $a0, Lose
li $v0, 4 # "LOSE!"
syscall
j loop

li $v0, 10
syscall

IfBetSizeGreater:
la $a0, BetSizeGreater
li $v0, 4
syscall
li $v0, 10
syscall
