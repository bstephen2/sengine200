/*
 *	sengine
 *	A threaded program for solving directmate chess problems.
 *
 *	(c) 2020-2021, Brian Stephenson
 * brian@bstephen.me.uk
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include "sengine.h"

int process_args(int, char**);

static int rc = 0;
static clock_t prog_start, prog_end;
static double run_time;

static void toFinish()
{
//    if (rc != 0) {
    prog_end = clock();
    run_time = (double)(prog_end - prog_start) / CLOCKS_PER_SEC;
    printf("Runtime = %3.6f\n", run_time);
//   }

    return;
}

int main(int argc, char* argv[])
{
    int atrc;
    prog_start = clock();

    atrc = atexit(toFinish);
    assert(atrc == 0);

    rc = process_args(argc, argv);

    return rc;
}

