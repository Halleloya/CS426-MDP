#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <omp.h>
#include <time.h>
#define SIZE 2000

int A[SIZE][SIZE], B[SIZE][SIZE];
long long int C[SIZE][SIZE], D[SIZE][SIZE];

void handler(int n, int threadNum)
{
    bool flag = 1;
    double parallelTime, serialTime;
    double startTime, endTime;

    omp_set_num_threads(threadNum);

    //generate matrix
    srand((unsigned)time(NULL));
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            A[i][j] = rand() % 1000000000;
            B[i][j] = rand() % 1000000000;
        }
    }

    //serial
    startTime = omp_get_wtime();
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<n; j++)
        {
            C[i][j] = 0;
            for(int k=0; k<n; k++)
            {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    endTime = omp_get_wtime();
    serialTime = endTime - startTime;
    printf("%f s\n", serialTime);

    //parallel
    startTime = omp_get_wtime();
    #pragma omp parallel shared (A, B, C)
    {
        #pragma omp for schedule(dynamic)
        for(int i=0; i<n; i++)
        {
            for(int j=0; j<n; j++)
            {
                D[i][j] = 0;
                for(int k=0; k<n; k++)
                {
                    D[i][j] += A[i][k] * B[k][j];
                }
            }
        }
    }

    endTime = omp_get_wtime();
    parallelTime = endTime - startTime;
    printf("%f s\n", parallelTime);

    for(int i=0; i<n; i++)
        for(int j=0; j<n; j++)
        {
            if(C[i][j] == D[i][j]);
            else flag = 0;
        }

    if(flag)
	printf("yes\n");
    else
	printf("no\n");
}


int main()
{
    int n = 1000, threadNum = 4;
    handler(n, threadNum);

    return 0;
}

