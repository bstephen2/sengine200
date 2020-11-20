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
extern unsigned char g_moves;
extern bool g_meson;
extern bool g_classify;

enum SOUNDNESS sound;

int process_args(int, char**);
void init();
void init_mem();
void close_mem();
BOARD* setup_diagram(enum COLOUR);
int validate_board(BOARD*);
void solve_direct(DIR_SOL*, BOARD*);
void freeBoardlist(BOARDLIST*);
void freeBoard(BOARD*);
void xml_start();
void xml_set(BOARDLIST*);
void xml_tries(BOARDLIST*);
void xml_keys(BOARDLIST*);
void xml_options();
void xml_stats(DIR_SOL*);
void xml_time(double);
void xml_end();

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

    if (rc != 0) {
        prog_end = clock();
        run_time = (double)(prog_end - prog_start) / CLOCKS_PER_SEC;
        printf("Runtime = %3.6f\n", run_time);
    }

    return;
}

void do_direct(BOARD* init_pos)
{
    DIR_SOL* dir_sol;
    dir_sol = (DIR_SOL*) calloc(1, sizeof(DIR_SOL));
    SENGINE_MEM_ASSERT(dir_sol);
    solve_direct(dir_sol, init_pos);
    xml_start();

    if (dir_sol->set != NULL) {
        xml_set(dir_sol->set);
    }

    if (dir_sol->tries != NULL) {
        xml_tries(dir_sol->tries);
    }

    if (dir_sol->keys != NULL) {
        xml_keys(dir_sol->keys);
    }

    if (g_meson == false) {
        xml_options();
        xml_stats(dir_sol);
    }

    prog_end = clock();
    run_time = (double)(prog_end - prog_start) / CLOCKS_PER_SEC;

    if (g_meson == false) {
        xml_time(run_time);
    }

    xml_end();

    if ((g_classify == true) && (g_moves == 2) && (sound == SOUND)) {
        //class_direct_2(dir_sol, init_pos);
    }

    if (dir_sol->set != NULL) {
        freeBoardlist(dir_sol->set);
    }

    if (dir_sol->tries != NULL) {
        freeBoardlist(dir_sol->tries);
    }

    if (dir_sol->keys != NULL) {
        freeBoardlist(dir_sol->keys);
    }

    free(dir_sol);
    freeBoard(init_pos);
    return;
}

int main(int argc, char* argv[])
{
    int atrc;
    prog_start = clock();

    atrc = atexit(toFinish);
    assert(atrc == 0);

    rc = process_args(argc, argv);

    if (rc == 0) {
        BOARD* init_pos;
        init();
        init_mem();
        init_pos = setup_diagram(BLACK);
        rc = validate_board(init_pos);

        if (rc == 0) do_direct(init_pos);

        close_mem();
    }

    return rc;
}

