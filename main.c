#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
	srand(time(NULL));
	double initialBalance, balance, houseEdge;
	double fairness, winCount = 0, loseCount = 0;
	double goal;
	int betSize, saveBetSize/*, goal*/;
	printf("Enter starting balance: ");
	scanf("%lf", &initialBalance);
	balance = initialBalance; // As�l de�eri korumak i�in.
	printf("Enter house edge (%%): ");
	scanf("%lf", &houseEdge);
	printf("Enter initial bet size: ");
	scanf("%d", &betSize);
	if (betSize > initialBalance)
	{
		printf("Bet size can not be greater than your starting balance!\n");
		system("pause");
		return 0;
	}
	printf("Enter your goal (for doubling your money, enter 2): ");
	scanf("%lf", &goal);
	saveBetSize = betSize; // Win durumunda multiplier katlanmas�n� durdurmak i�in.
	int multiplier = 2; // 2'ye katlama oyunu oynuyoruz. Yaz� tura gibi.
	//goal = 2; // Amac�m�z ana paray� 2'ye katlamak.
	fairness = 100 - houseEdge;
	do {
		double result = rand() % 100;
		if (result < 50) // Kazan�rsa
		{
			if (result < 10) // 1 yerine 01 yazmas� i�in ufak bir loop.
			{
				printf("0");
			}
			printf("%02.02lf WIN!\n", result);
			printf("		bet size: %d\n\n", betSize);
			initialBalance = initialBalance + (betSize * (multiplier * (fairness / 100)) - betSize); // �lk bakiyeye kazan� eklenir, komisyon al�n�r.
			printf("				balance: %.2lf", initialBalance);
			printf("\n\n");
			betSize = saveBetSize;
			winCount++;
			if (initialBalance >= (balance*goal))
				break;
		}
		else if (result > 50) // Kaybederse
		{
			printf("%02.02lf LOSE!\n", result);
			printf("		bet size: %d\n\n", betSize);
			initialBalance = initialBalance - (betSize);
			printf("				balance: %.2lf", initialBalance);
			printf("\n\n");
			betSize = betSize * multiplier;
			loseCount++;
		}
	} while (betSize <= initialBalance);


	printf("balance: %.2lf\n\n", initialBalance);
	printf("%.lf times win, %.lf times lost.\n", winCount, loseCount);
	if (initialBalance >= (balance*goal))
		printf("Amacimiz, elimizdeki %.2lf parayi martingale sistemi ile %.2lf yapmakti, BASARDIK! :D\n", balance, (balance*goal));
	else if (initialBalance < (balance*goal))
		printf("Amacimiz, elimizdeki %.2lf parayi martingale sistemi ile %.2lf yapmakti, BASARAMADIK! :(\n", balance, (balance*goal));
	double luck = ((((winCount / loseCount) - 1) * 100) + 100)/* * ((houseEdge / 100) + 1)*/; // kazan�lan say� kaybedilene b�l�nerek y�zde hesaplan�r, houseEdge dikkate ALINMAZ.
	printf("%% %.2lf oraninda sansliydik.(ideal sans %%100'dur.)\n", luck);
	system("pause");
	return 0;
}