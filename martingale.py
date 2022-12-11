import random
import matplotlib.pyplot as plt

print('### Martingale vs House Edge Game ###')
print('Enter a house edge (%):')
edge=int(input())
print('Enter a starting bet (e.g. 1): ')
minBet=int(input())
print('Enter your starting balance (e.g. 1000): ')
balance=int(input())
print('Starting...')

betSize=minBet
AmountOfBets=0
balanceOverTime=[balance]

while balance > 0 and betSize <=balance:
    randNumber=random.randint(0,9999) # from 0 to 9999, in a total of 10,000 possibilities...
    if randNumber<5000-(5000*(edge/100)): # if the random number is less than 5000-(5000*(edge/100)):
        balance+=betSize # we win! add the betSize to the balance...
        betSize=minBet # and set the betSize to the minBet.
    else: # if we lose...
        balance-=betSize # subtract the betSize from the balance, and...
        betSize=betSize*2 # double the betsize for the next bet.
    balanceOverTime.append(balance)
    AmountOfBets+=1
print('Ending balance: ' + str(balance))
print('Amount of bets: ' + str(AmountOfBets))
print('Highest bet (last bet): ' + str(betSize/2))

x_range = list(range(0, AmountOfBets+1))
plt.plot(x_range, balanceOverTime)
plt.ylabel('balance')
plt.xlabel('amount of bets')
plt.show()