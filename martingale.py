import secrets
import matplotlib.pyplot as plt

print('### Martingale vs House Edge Game ###')
print('Enter a house edge (%):')
edge=int(input())
print('Enter a starting bet (e.g. 1): ')
minBet=int(input())
print('Enter your starting balance (e.g. 1000): ')
balance=int(input())
print('Enter your target balance (e.g. 2000): ')
target=int(input())
print('Starting...')

betSize=minBet
AmountOfBets=0
balanceOverTime=[balance]
winCount=0
loseCount=0

while balance > 0 and betSize <=balance and target >= balance: # Play while balance is more than zero, and the bet size is less than balance, and the target is more than or equal to the balance.
    randNumber=secrets.SystemRandom().randint(0, 9999) # from 0 to 9999, in a total of 10,000 possibilities...
    if randNumber<5000-(5000*(edge/100)): # if the random number is less than 5000-(5000*(edge/100)):
        balance+=betSize # we win! add the betSize to the balance...
        betSize=minBet # and set the betSize to the minBet.
        winCount+=1
    else: # if we lose...
        balance-=betSize # subtract the betSize from the balance, and...
        betSize*=2 # double the betSize for the next bet.
        loseCount+=1
    balanceOverTime.append(balance)
    AmountOfBets+=1
print('Ending balance: ' + str(balance))
print('Amount of bets: ' + str(AmountOfBets))
print('Total number of wins: ' + str(winCount))
print('Total number of losses: ' + str(loseCount))
if loseCount > 0:
    print('Luck: ' + str(((winCount*(1+edge/100))/(loseCount/(1/(1-edge/100)))*100)) + '%')

x_range = list(range(0, AmountOfBets+1))
plt.plot(x_range, balanceOverTime)
plt.ylabel('balance')
plt.xlabel('amount of bets')
plt.show()