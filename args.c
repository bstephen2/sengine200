/*
 *	sengine
 *	A threaded program for solving directmate chess problems.
 *
 *	(c) 2020-2021, Brian Stephenson
 * brian@bstephen.me.uk
 *
 */

#include <stdio.h>
#include <getopt.h>
#include "sengine.h"

extern uchar* g_kings;
extern uchar* g_gbr;
extern uchar* g_pos;
extern uchar* g_castling;
extern uchar* g_ep;
extern uchar g_moves;
extern uchar g_sols;
extern uchar g_refuts;
extern uchar g_threats;
extern bool	g_hash;
extern bool	g_help;
extern bool	g_set;
extern bool	g_tries;
extern bool	g_trivtries;
extern bool	g_actual;
extern bool	g_shortvars;
extern bool	g_fleck;
extern bool	g_meson;
extern bool	g_classify;
extern bool	g_version;

void do_usage(void)
{
    (void) fputs("USAGE: sengine\n", stderr);
    (void) fputs(" --kings=s          king positions - eg. a1b4\n", stderr);
    (void) fputs(" --gbr=s            GBR code - eg. 1888.23\n", stderr);
    (void) fputs(" --pos=s            position\n", stderr);
    (void) fputs(" [--moves=i]        Moves (default = 2) 1-9 are valid\n", stderr);
    (void) fputs(" [--sols=i]         Solutions (default = 1) 1-9 are valid\n", stderr);
    (void) fputs(" [--castling=s]     Castling rights - eg. KQkq for full castling\n", stderr);
    (void) fputs(" [--ep=s]           Square of a pawn that can be taken ep\n", stderr);
    (void) fputs(" [--refuts=i]       Number of refutations for tries (default = 0) 1-9 are valid\n", stderr);
    (void) fputs(" [--threats=s]      Calculate threats - NONE, SHORTEST (the default) or ALL\n", stderr);
    (void) fputs(" [--hash]           Use a transposition hash table\n", stderr);
    (void) fputs(" [--help]           Display this help message\n", stderr);
    (void) fputs(" [--set]            Calculate set play\n", stderr);
    (void) fputs(" [--tries]          Calculate tries\n", stderr);
    (void) fputs(" [--trivialtries]   Include trivial tries\n", stderr);
    (void) fputs(" [--actual]         Calculate actual play\n", stderr);
    (void) fputs(" [--shortvars]      Include short variations\n", stderr);
    (void) fputs(" [--fleck]          Retain variations that allow some (but not all) of the threats\n", stderr);
    (void) fputs(" [--meson]          Running from Meson database, default is false\n", stderr);
    (void) fputs(" [--classify]       Classify problem\n", stderr);
    (void) fputs(" [--version]        Display program version\n", stderr);

    return;
}

int process_args(int argc, char* argv[])
{
    int rc = 0;
    int option_index = 0;
    int opt;

    struct option long_options[] = {
        {"kings",        no_argument,       0, 'a' },
        {"gbr",          required_argument, 0, 'b' },
        {"pos",          required_argument, 0, 'c' },
        {"moves",        required_argument, 0, 'd' },
        {"sols",         required_argument, 0, 'e' },
        {"castling",     required_argument, 0, 'f' },
        {"ep",           required_argument, 0, 'g' },
        {"refuts",       required_argument, 0, 'h' },
        {"threats",      required_argument, 0, 'i' },
        {"hash",         no_argument,       0, 'j' },
        {"help",         no_argument,       0, 'k' },
        {"set",          no_argument,       0, 'l' },
        {"tries",        no_argument,       0, 'm' },
        {"trivialtries", no_argument,       0, 'n' },
        {"actual",       no_argument,       0, 'o' },
        {"shortvars",    no_argument,       0, 'p' },
        {"fleck",        no_argument,       0, 'q' },
        {"meson",        no_argument,       0, 'r' },
        {"classify",     no_argument,       0, 's' },
        {"version",      no_argument,       0, 't' },
        {0,              0,                 0, 0 }
    };

    while ((opt = getopt_long_only(argc, argv, "", long_options, &option_index)) != -1) {

        switch (opt) {
        case 'a':
            break;

        case 'b':
            break;

        case 'c':
            break;

        case 'd':
            break;

        case 'e':
            break;

        case 'f':
            break;

        case 'g':
            break;

        case 'h':
            break;

        case 'i':
            break;

        case 'j':
            g_hash = true;
            break;

        case 'k':
            g_help = true;
            break;

        case 'l':
            g_set = true;
            break;

        case 'm':
            g_tries = true;
            break;

        case 'n':
            g_trivtries = true;
            break;

        case 'o':
            g_actual = true;
            break;

        case 'p':
            g_shortvars = true;
            break;

        case 'q':
            g_fleck = true;
            break;

        case 'r':
            g_meson = true;
            break;

        case 's':
            g_classify = true;
            break;

        case 't':
            g_version = true;
            break;

        default:
            break;
        }
    }

    return rc;
}


