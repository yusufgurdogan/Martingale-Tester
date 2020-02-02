.data
enterbalance: .asciiz "Enter starting balance: "
enterhouseedge: .asciiz "Enter house edge (%):"
enterbetsize: .asciiz "Enter initial bet size:"
entergoal: .asciiz "Enter your goal (for doubling your money, enter 2):"
BetSizeGreater: .asciiz "Bet size can not be greater than your starting balance!\n"
YouHaveLost: .asciiz "You have lost the game."
YouHaveWon: .asciiz "You have won the game."
Win: .asciiz "WIN!"
Lose: .asciiz "LOSE!"
betsize: .asciiz "bet size: "
balance: .asciiz " balance: "
newLine: .asciiz "\n"
.text
.globl main
main:

la $a0, enterbalance
li $v0, 4
syscall

li $v0, 5 # scanf balance
syscall 
move $t3, $v0 # $t3 = balance, dynamic. changes on every bet.

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
move $t4, $v0 # $t4 = bet size, dynamic. gets multiplied by 2 if previous bet is a lose.
move $t5, $t4 # $t5 = initial bet size, static.

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
bgt $a0, 49, greaterThan
#lessThan:
la $a0, Win
li $v0, 4 # "WIN!"
syscall

la $a0, balance
li $v0, 4 # balance:
syscall
add $t3, $t3, $t4 # add winned amount to the balance
move $a0, $t3
li $v0, 1
syscall
la $a0, newLine
li $v0, 4 # "\n"
move $t4, $t5 # dynamic bet size is equal to initial bet size, because of martingale.
syscall
j loop

greaterThan:
la $a0, Lose
li $v0, 4 # "LOSE!"
syscall

la $a0, balance
li $v0, 4 # balance:
syscall
sub $t3, $t3, $t4 # subtract winned amount to the balance
move $a0, $t3
li $v0, 1
syscall
la $a0, newLine
li $v0, 4 # "\n"
syscall
mul $t4, $t4, 2 # t4 = t4 * 2
bge $t4, $t3, InsufficientBalance # If balance is insufficient, stop.
j loop

li $v0, 10 # exit
syscall

IfBetSizeGreater:
la $a0, BetSizeGreater
li $v0, 4
syscall
li $v0, 10
syscall

InsufficientBalance:
la $a0, YouHaveLost
li $v0, 4
syscall
li $v0, 10
syscall
