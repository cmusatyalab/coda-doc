#ifndef _BLURB_
#define _BLURB_
/*
                           CODA FILE SYSTEM
                      School of Computer Science
                      Carnegie Mellon University
                          Copyright 1987-92

Past and present contributors to Coda include M. Satyanarayanan, James
Kistler, Puneet Kumar, David  Steere,  Maria  Okasaki,  Lily  Mummert,
Ellen  Siegel,  Brian  Noble, Anders Klemets, Masashi Kudo, and Walter
Smith.  The use of Coda outside Carnegie Mellon University requires  a
license.  Contact the Coda project coordinator for licensing details.
*/


static char *rcsid = "$Header$";
#endif _BLURB_

/*

	M. Satyanarayanan
	Department of Computer Science
	Carnegie-Mellon University
	
*/


#include <stdio.h>
#include <sys/time.h>

#define COLS 4
#define MINICOUNT 4
#define MAXRETRY  10
struct timeval OneRow[COLS][MAXRETRY+2];	/* array of timeout intervals */

#define LOWERLIMIT 300000   /* in microseconds */

main()
    {
    DoPage(1, 15, 15);
    DoPage(2, 90, 30);
    DoPage(3, 240, 60);
    }


DoPage(Pno, LowT, StepT)
    int Pno, LowT, StepT;
    {
    int i, retries;

    printf("@newpage\n");
    printf("@begin(Table, Size -2)\n");
    printf("@StandardTable(Name RTable%d, Columns %d, FirstColumn Flushleft, Othercolumns Center, ColumnLined, HeadingBoxed)\n", Pno, COLS+1);
    printf("@begin(RTable%d)\n", Pno);
    printf("@tableid(RTable%d)\n", Pno);
    printf("@TableHeading(Immediate, RowFormat RTable%dColumnHeadings, Line <", Pno);
    for (i = 0; i < COLS; i++) printf("@\\%d secs", LowT+i*StepT);
    printf(">)\n");

    for (retries = 1; retries <= MAXRETRY; retries++)
	{
	MakeRow(retries, LowT, StepT);
	PrintRow(retries, LowT, StepT);
	BlankLine();
	}
    printf("@end(RTable%d)\n", Pno);
    printf("@caption[Retry Constants for B@-<total> = %d to %d secs (%d msecs lower limit)]\n",
	    LowT, LowT+(COLS-1)*StepT, LOWERLIMIT/1000);
    printf("@end(Table)\n");
    }

PrintRow(RCount, LowT, StepT)
    int RCount, LowT, StepT;
    {
    register int i, thiscol;
    int minirows, thismini;
    
    minirows = (RCount+MINICOUNT)/MINICOUNT;

    for (thismini = 0; thismini < minirows; thismini++)
    	{
	if (thismini == 0) printf("%d retries", RCount);

	for (thiscol = 0; thiscol < COLS; thiscol++)
	    {
	    printf("@\\");
	    for (i = 1 + thismini*MINICOUNT; i < 1 + (thismini+1)*MINICOUNT; i++)
	    	{
		if (i == RCount+1)
		    {
		    printf("(%d.%d)",OneRow[thiscol][i].tv_sec, (OneRow[thiscol][i].tv_usec+5000)/10000);
		    break;
		    }
		else printf("%d.%d ",OneRow[thiscol][i].tv_sec, (OneRow[thiscol][i].tv_usec+5000)/10000);
		}
	    }
	printf("\n\n");
	}
    }

MakeRow(RCount, LowT, StepT)
    int RCount, LowT, StepT;
    {
    struct timeval tt;
    register int i, j;

    for (i = 0; i < RCount; i++)
	{
	for (j = 0; j < COLS; j++)
	    {
	    tt.tv_sec = LowT + j*StepT;
	    tt.tv_usec = 0; 
	    SetRetry(i+1, &tt, OneRow[j]);
	    }
	}
    }




SetRetry(RCount, Beta0, BetaArray)
    long RCount;		/* should be less than 30 */
    struct timeval *Beta0;	
    struct timeval BetaArray[];
    /*
    	(1)	Beta[i+1] = 2*Beta[i]
	(2)	Beta[0] = Beta[1] + Beta[2] ... + Beta[RCount+1]

    Time constants less than LowerLimit are set to LowerLimit.
    */
    {
    register long betax, timeused, beta0;	/* entirely in microseconds */
    register long i;


    bzero(BetaArray, sizeof(struct timeval)*(2+RCount));
    BetaArray[0] = *Beta0;	/* structure assignment */
    /* compute BetaArray[1] .. BetaArray[N] */
    betax = (1000000*BetaArray[0].tv_sec + BetaArray[0].tv_usec)/((1 << (RCount+1)) - 1);
    beta0 = (1000000*BetaArray[0].tv_sec + BetaArray[0].tv_usec);
    timeused = 0;
    for (i = 1; i < RCount+2 && beta0 > timeused; i++)
	{
	if (betax < LOWERLIMIT)	/* NOTE: we don't bother with (beta0 - timeused < LOWERLIMIT) */
	    {
	    BetaArray[i].tv_sec = 0;
	    BetaArray[i].tv_usec = LOWERLIMIT;
	    timeused += LOWERLIMIT;
	    }
	else
	    {
	    if (beta0 - timeused > betax)
		{
		BetaArray[i].tv_sec = betax/1000000;
		BetaArray[i].tv_usec = betax % 1000000;
		timeused += betax;
		}
	    else
		{
		BetaArray[i].tv_sec = (beta0 - timeused)/1000000;
		BetaArray[i].tv_usec = (beta0 - timeused)%1000000;
		timeused = beta0;
		}
	    }
	betax = betax << 1;
	}
    }


BlankLine()
    {
    int i;
    for (i = 0; i < COLS; i++) printf("@\\");
    printf("\n\n");
    }
