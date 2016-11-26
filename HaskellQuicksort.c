#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#include "Quicksort_stub.h"

typedef int bool;
#define true 1
#define false 0

long* range(const unsigned long);
void shuffle(long* const, const unsigned long);
//extern void quickSort(long* const, const unsigned long);
bool isSorted(long* const, const unsigned long);

int main(int argc, char *argv[])
{
    hs_init(&argc, &argv);
    
    srand (time(NULL));
    const unsigned long myData_len = 10000;
    const unsigned int num_trials = 10;
    long* myData = range(myData_len);
    double myQSortTime = 0;
    double marshalTime = 0;
    clock_t start;
    printf("Array Size: %lu\nNumber of Trials: %u\n", myData_len, num_trials);
    printf("Starting trials...\n");

    for(unsigned int i=0; i<num_trials; i++)
    {
        shuffle(myData, myData_len);
        start = clock();
        quickSort(myData, myData_len);
        myQSortTime += (clock() - start)/(double)CLOCKS_PER_SEC;

        start = clock();
        marshalTest(myData, myData_len);
        marshalTime += (clock() - start)/(double)CLOCKS_PER_SEC;
        
        if(!isSorted(myData, myData_len)) {
            printf("Bad sort!\n");
            for(unsigned long i=0; i<myData_len; i++)
            {
                printf("%lu", myData[i]);
            }
            printf("\n");
        }
        //else {
        //    printf("Array properly sorted!\n");
        //}
    }

    printf("QSort avg time (s): %lf\n", myQSortTime/num_trials);
    printf("Marshal avg time (s): %lf\n", marshalTime/num_trials);
    printf("Difference (s): %lf\n", myQSortTime/num_trials-marshalTime/num_trials);

	free(myData);
    hs_exit();
    return 0;
}


long* range(const unsigned long len)
{
    long* lst = (long*) malloc(sizeof(long)*len);
    for(unsigned long i=0; i<len; i++)
    {
        lst[i] = i;
    }
    return lst;
}

void shuffle(long* lst, const unsigned long len)
//Does an in-place shuffle of lst with length len
{
  for(unsigned long i=0; i<len; i++)
  {
    unsigned long target = rand()%(len-i)+i;
    long temp = lst[target];
    lst[target] = lst[i];
    lst[i] = temp;
  }
}

bool isSorted(long* const lst, const unsigned long len)
{
    for(long i=0; i<len-1; i++)
    {
        if(lst[i+1]<lst[i])
            return false;
    }
    return true;
    
}
