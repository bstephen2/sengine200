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
#include <string.h>
#include "sengine.h"

char* g_kings = NULL;
char* g_gbr = NULL;
char* g_pos = NULL;
char* g_castling = NULL;
char* g_ep = NULL;
char* g_st_moves = NULL;
char* g_st_sols = NULL;
char* g_st_refuts = NULL;
char* g_st_threats = NULL;
unsigned char g_moves = 2;
unsigned char g_sols = 1;
unsigned char g_refuts = 0;
enum THREATS g_threats = SHORTEST;
bool g_hash = false;
bool g_help = false;
bool g_set = false;
bool g_tries = false;
bool g_trivtries = false;
bool g_actual = false;
bool g_shortvars = false;
bool g_fleck = false;
bool g_meson = false;
bool g_classify = false;
bool g_version = false;

int val_kings(char*);
int val_gbr(char*);
int val_pos(char*);
int val_castling(char*);
int val_ep(char*);
int val_moves(char*);
int val_sols(char*);
int val_refuts(char*);
int val_threats(char*);
int val_gbr_pos(char*, char*);
int val_kings_pos(char*, char*);

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
        {"kings",        required_argument, 0, 'a' },
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
        case 'a':			// --kings
            g_kings = strdup(optarg);
            break;

        case 'b':			// --gbr
            g_gbr = strdup(optarg);
            break;

        case 'c':			// --pos
            g_pos = strdup(optarg);
            break;

        case 'd':			// --moves
            g_st_moves = strdup(optarg);
            break;

        case 'e':			// --sols
            g_st_sols = strdup(optarg);
            break;

        case 'f':			// --castling
            g_castling = strdup(optarg);
            break;

        case 'g':			//	--ep
            g_ep = strdup(optarg);
            break;

        case 'h':			// --refuts
            g_st_refuts = strdup(optarg);
            break;

        case 'i':			// --threats
            g_st_threats = strdup(optarg);
            break;

        case 'j':			// --hash
            g_hash = true;
            break;

        case 'k':			// --help
            g_help = true;
            break;

        case 'l':			// --set
            g_set = true;
            break;

        case 'm':			// --tries
            g_tries = true;
            break;

        case 'n':			// --trivialtries
            g_trivtries = true;
            break;

        case 'o':			// --actual
            g_actual = true;
            break;

        case 'p':			// --shortvars
            g_shortvars = true;
            break;

        case 'q':			// --fleck
            g_fleck = true;
            break;

        case 'r':			// --meson
            g_meson = true;
            break;

        case 's':			// --classify
            g_classify = true;
            break;

        case 't':			// --version
            g_version = true;
            break;

        case '?':			// Error
            rc++;
            break;

        default:
            break;
        }
    }

    if (rc != 0) {
        do_usage();
    } else {
        if ((g_help == true) || (g_version == true)) {
            if (g_version == true) {
                fprintf(stderr, "%s (v. %s)\n", SENGINE_PROG_NAME, SENGINE_PROG_VERSION);
                fprintf(stderr, "(c) %s, %s\n", SENGINE_PROG_YEARS, SENGINE_PROG_AUTHOR);
            }

            if (g_help == true) {
                do_usage();
            }

            rc = 1;
            return rc;
        }
    }

    if (rc == 0) {
        if (g_kings == NULL) {
            fprintf(stderr, "%s--kings is mandatory\n", SENGINE_ERROR_PREFIX);
            rc++;
        }

        if (g_gbr == NULL) {
            fprintf(stderr, "%s--gbr is mandatory\n", SENGINE_ERROR_PREFIX);
            rc++;
        }

        if (g_pos == NULL) {
            fprintf(stderr, "%s--pos is mandatory\n", SENGINE_ERROR_PREFIX);
            rc++;
        }
    }

    if ((g_kings != NULL) && (val_kings(g_kings) != 0)) {
        fprintf(stderr, "%s--kings=%s is invalid\n", SENGINE_ERROR_PREFIX, g_kings);
        rc++;
    }

    if ((g_gbr != NULL) && (val_gbr(g_gbr) != 0)) {
        fprintf(stderr, "%s--gbr=%s is invalid\n", SENGINE_ERROR_PREFIX, g_gbr);
        rc++;
    }

    if ((g_pos != NULL) && (val_pos(g_pos) != 0)) {
        fprintf(stderr, "%s--pos=%s is invalid\n", SENGINE_ERROR_PREFIX, g_pos);
        rc++;
    }

    if ((g_castling != NULL) && (val_castling(g_castling) != 0)) {
        fprintf(stderr, "%s--castling=%s is invalid\n", SENGINE_ERROR_PREFIX, g_castling);
        rc++;
    }

    //rc += val_ep(g_ep);
    //rc += val_moves(g_st_moves);
    //rc += val_refuts(g_st_refuts);
    //rc += val_threats(g_st_threats);king

    if ((g_fleck == true) && (g_threats == NONE)) {
        rc++;
        fprintf(stderr, "%s--fleck and --threats==NONE invalid", SENGINE_ERROR_PREFIX);
    }

    if ((g_refuts > 0) && (g_tries == false)) {
        rc++;
        fprintf(stderr, "%s--refuts only valid with --tries", SENGINE_ERROR_PREFIX);
    }

    if ((g_hash == true) && (g_moves < 5)) {
        rc++;
        fprintf(stderr, "%s--hash only valid with --moves > 4", SENGINE_ERROR_PREFIX);
    }

    if ((g_tries == true) && (g_refuts == 0)) {
        g_refuts = 1;
    }

    if (g_pos != NULL) {
        //if (g_gbr != NULL) rc += val_gbr_pos(g_gbr, g_pos);

        //if (g_kings != NULL) rc += val_kings_pos(g_kings, g_pos);
    }

    if (rc != 0) {
        fputs("\nTry sengine200 --help for guidance\n", stderr);
    }

    return rc;
}


