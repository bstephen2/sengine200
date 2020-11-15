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

extern char* g_kings;
extern char* g_gbr;
extern char* g_pos;
extern char* g_castling;
extern char* g_ep;
extern char* g_st_moves;
extern char* g_st_sols;
extern char* g_st_refuts;
extern char* g_st_threats;

int process_args(int, char**);

static int rc = 0;
static clock_t prog_start, prog_end;
static double run_time;

static void toFinish()
{
    if (g_kings != NULL) free(g_kings);

    if (g_gbr != NULL) free(g_gbr);

    if (g_pos != NULL) free(g_pos);

    if (g_castling != NULL) free(g_castling);

    if (g_ep != NULL) free(g_ep);

    if (g_st_moves != NULL) free(g_st_moves);

    if (g_st_sols != NULL) free(g_st_sols);

    if (g_st_refuts != NULL) free(g_st_refuts);

    if (g_st_threats != NULL) free(g_st_threats);

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

