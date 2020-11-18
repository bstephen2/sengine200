/*
 *	sengine
 *	A threaded program for solving directmate chess problems.
 *
 *	(c) 2020-2021, Brian Stephenson
 * brian@bstephen.me.uk
 *
 */

#include <stdbool.h>
#include <stdint.h>

#define SENGINE_PROG_NAME "Sengine"
#define SENGINE_PROG_VERSION "2.00"
#define SENGINE_PROG_AUTHOR "Brian Stephenson"
#define SENGINE_PROG_YEARS "2020-2021"
#define SENGINE_ERROR_PREFIX "sengine200: "

typedef unsigned char uchar;

enum THREATS { ALL, NONE, SHORTEST };
enum COLOUR { WHITE, BLACK };
enum STATUS { SETPLAY, THREATS, TRIESKEYS };
enum PIECE { NOPIECE = 0, OCCUPIED = 0, PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING
           };
enum SOUNDNESS { UNSET, SHORT_SOLUTION, SOUND, COOKED, NO_SOLUTION,
                 MISSING_SOLUTION
               };

typedef uint64_t BITBOARD;

