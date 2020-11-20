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
#include "uthash.h"
#include "utlist.h"
#include "utstring.h"

#define SENGINE_PROG_NAME "Sengine"
#define SENGINE_PROG_VERSION "2.00"
#define SENGINE_PROG_AUTHOR "Brian Stephenson"
#define SENGINE_PROG_YEARS "2020-2021"
#define SENGINE_ERROR_PREFIX "sengine200: "
#define MD5_LEN 16
#define KILLERKEY_LEN 3
#define NOSTIP 100
#define B_KING_CASTLING 2
#define B_QUEEN_CASTLING 4
#define W_KING_CASTLING 8
#define W_QUEEN_CASTLING 16

#define SENGINE_MEM_ASSERT(X) if ((X) == NULL) \
{ \
    fprintf(stderr, "OUT OF MEMORY at %s(%d)\n", __FILE__, __LINE__); \
    exit(1); \
}

#define FILE(a) ((a) & 7)

#define RANK(a) ((a) >> 3)

#define SQUARE_TO_INT(a) (( *((a) + 1) -1 - '0')*8 + (*(a) - 'a'))

#define ISWHITEINCHECK(a) \
	attacks((a), (a)->kingsq[0], BLACK)

#define ISBLACKINCHECK(a) \
	attacks((a), (a)->kingsq[1], WHITE)

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

typedef struct BBOARD {
    BITBOARD bb;
    bool used;
} BBOARD;

typedef struct POSITION {
    BITBOARD bitBoard[2][7];     /*  The position this move created */
    unsigned char kingsq[2];     /*  The squares of the kings, white then black. */
    unsigned char flags;         /*  Various flags. */
} POSITION;

typedef struct BOARDLIST {
    struct BOARD* vektor;
    unsigned char legalMoves;
    bool isTry;
    unsigned char maxStip;
    unsigned char minStip;
    unsigned char moveNumber;
    unsigned char stipIn;
    unsigned char use_count;
    enum COLOUR toPlay;
} BOARDLIST;

typedef struct BOARD {
    POSITION* pos;
    BOARDLIST* nextply;          /*  A pointer to the boardlist containing the next moves from this position. */
    BOARDLIST* threat;           /*  A pointer to the boardlist containing the threats active from this position. */
    unsigned char ply;           /* Move number. */
    enum COLOUR side;            /* The side that played this move */
    enum PIECE mover;            /* The piece that moved */
    unsigned char from;          /*  The square the piece moved from. */
    unsigned char to;            /* The square the piece moved to. */
    char qualifier[3];           /* The notation qualifier to qualify otherwise ambiguous moves */
    bool captured;               /*  Whether the move was a capture. */
    enum PIECE promotion;        /*  Piece promoted to, if any. */
    bool check;                  /*  Whether the move was a check. */
    char tag;                    /*  ? '#', '=', '+', '!', '?', '*'. */
    bool ep;                     /*  Whether this move was an ep capture. */
    unsigned char epSquare;      /*  The square on which a pawn can be captured ep from this position. */
    unsigned char flights;
    unsigned char use_count;
    bool killer;
    struct BOARD* prev;
    struct BOARD* next;
} BOARD;

typedef struct ID_BOARD {
    char white_ids[65];
    char black_ids[65];
} ID_BOARD;

typedef struct CHECK_SQUARE_LIST {
    int count;
    int square[2];
    enum PIECE real_piece[2];
    enum PIECE as_piece[2];
} CHECK_SQUARE_LIST;

typedef struct PIN_STATUS {
    UT_string* w_before;
    UT_string* w_after;
    UT_string* b_before;
    UT_string* b_after;
} PIN_STATUS;

typedef struct HASH_VAR {
    char* class;
    UT_hash_handle hh;
} HASH_VAR;

typedef struct HASHKEY {
    unsigned char hashkey[16];
} HASHKEY;

typedef struct HASHVALUE {
    unsigned char hashkey[16];
    BOARDLIST* cont;
    UT_hash_handle hh;
} HASHVALUE;

typedef struct KILLERKEY {
    unsigned char kkey[3];
} KILLERKEY;

typedef struct KILLERHASHVALUE {
    unsigned char kkey[3];
    int count;
    UT_hash_handle hh;
} KILLERHASHVALUE;

typedef struct DIR_SOL {
    BOARDLIST* set;
    BOARDLIST* tries;
    BOARDLIST* keys;
    BOARDLIST* trieskeys;
    unsigned int hash_added;
    unsigned int hash_hit_null;
    unsigned int hash_hit_list;
} DIR_SOL;
