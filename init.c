/*
 *	sengine
 *	A threaded program for solving directmate chess problems.
 *
 *	(c) 2020-2021, Brian Stephenson
 * brian@bstephen.me.uk
 *
 */


#include <omp.h>
#include "sengine.h"

static const int knightsq[] = { -17, -15, -10, -6, 6, 10, 15, 17 };
static const int bishopsq[] = { -9, -7, 7, 9 };
static const int rooksq[] = { -8, -1, 1, 8 };

extern BITBOARD g_setMask[64];
extern BITBOARD g_clearMask[64];
extern BITBOARD g_king_attacks[64];
extern BITBOARD g_knight_attacks[64];
extern BITBOARD g_bishop_attacks[64];
extern BITBOARD g_rook_attacks[64];
extern BITBOARD g_pawn_attacks[2][64];
extern BITBOARD g_pawn_moves[2][64];
BBOARD rook_commonAttacks[64][64];
BBOARD bishop_commonAttacks[64][64];
uint64_t hash_added;
uint64_t hash_hit;
uint64_t board_del;
uint64_t boardlist_del;
uint64_t position_del;

static void init_kingattacks(void);
static void init_knightattacks(void);
static void init_bishopattacks(void);
static void init_bishopcommonattacks(void);
static void init_rookattacks(void);
static void init_rookcommonattacks(void);
static void init_pawnmoves(void);

static int meson_max(int a, int b)
{
    return ((a > b) ? a : b);
}

static int meson_min(int a, int b)
{
    return ((a < b) ? a : b);
}

static int fileDistance(int a, int b)
{
    return abs(FILE(a) - FILE(b));
}

static int rankDistance(int a, int b)
{
    return abs(RANK(a) - RANK(b));
}

static int distance(int a, int b)
{
    return meson_max(fileDistance(a, b), rankDistance(a, b));
}

static bool isEdge(int a)
{
    int i = RANK(a);

    if ((i == 0) || (i == 7)) {
        return true;
    }

    i = FILE(a);

    if ((i == 0) || (i == 7)) {
        return true;
    }

    return false;
}

static bool isRookEdge(int dir, int pos)
{
    int xPos = FILE(pos);

    if ((dir == -1) && (xPos == 0)) {
        return true;
    }

    if ((dir == 1) && (xPos == 7)) {
        return true;
    }

    xPos = RANK(pos);

    if ((dir == -8) && (xPos == 0)) {
        return true;
    }

    if ((dir == 8) && (xPos == 7)) {
        return true;
    }

    return false;
}

void init(void)
{
    # pragma omp parallel
    {
        # pragma omp sections
        {
            # pragma omp section
            {
                init_kingattacks();
            }
            # pragma omp section
            {
                init_knightattacks();
            }
            # pragma omp section
            {
                init_bishopattacks();
            }
            # pragma omp section
            {
                init_rookattacks();
            }
            # pragma omp section
            {
                init_pawnmoves();
            }
        }
    }

    # pragma omp parallel
    {
        # pragma omp sections
        {
            # pragma omp section
            {
                init_bishopcommonattacks();
            }
            # pragma omp section
            {
                init_rookcommonattacks();
            }
        }
    }

    return;
}

static void init_kingattacks(void)
{
    int i, j;

    for (i = 0; i < 64; i++) {
        for (j = 0; j < 64; j++) {
            if (distance(i, j) == 1) {
                g_king_attacks[i] = g_king_attacks[i] | g_setMask[j];
            }
        }
    }

    return;
}

static void init_knightattacks(void)
{
    int i, j;

    for (i = 0; i < 64; i++) {
        int frank = RANK(i);
        int ffile = FILE(i);

        for (j = 0; j < 8; j++) {
            int sq = i + knightsq[j];

            if ((sq < 0) || (sq > 63)) {
                continue;
            }

            int trank = RANK(sq);
            int tfile = FILE(sq);

            if ((abs(frank - trank) > 2) || (abs(ffile - tfile) > 2)) {
                continue;
            }

            g_knight_attacks[i] = g_knight_attacks[i] | g_setMask[sq];
        }
    }

    return;
}

static void init_bishopattacks(void)
{
    int i, j;

    for (i = 0; i < 64; i++) {
        int iFile = FILE(i);
        int iRank = RANK(i);

        for (j = 0; j < 4; j++) {
            int inc = bishopsq[j];

            if ((iFile == 0) && ((inc == 7) || (inc == -9))) {
                continue;
            }

            if ((iFile == 7) && ((inc == 9) || (inc == -7))) {
                continue;
            }

            if ((iRank == 0) && (inc < 0)) {
                continue;
            }

            if ((iRank == 7) && (inc > 0)) {
                continue;
            }

            int pos = i + inc;
            assert((pos >= 0) && (pos <= 63));
            g_bishop_attacks[i] |= g_setMask[pos];

            while (isEdge(pos) == false) {
                pos = pos + inc;
                assert((pos >= 0) && (pos <= 63));
                g_bishop_attacks[i] |= g_setMask[pos];
            }
        }
    }

    return;
}

static void init_bishopcommonattacks(void)
{
    int i, j;
    (void) memset(bishop_commonAttacks, '\0', sizeof(BBOARD) * 64 * 64);

    for (i = 0; i < 64; i++) {
        for (j = 0; j < 64; j++) {
            if (i != j) {
                if ((g_bishop_attacks[i] & g_setMask[j]) != 0) {
                    int a = meson_min(i, j);
                    int b = meson_max(i, j);
                    BITBOARD temp = 0;

                    if ((FILE(a) > FILE(b))) {
                        /*
                           diagonal to the left
                         */
                        a += 7;

                        while (a != b) {
                            temp |= g_setMask[a];
                            a += 7;
                        }
                    } else {
                        /*
                           diagonal to the right
                         */
                        a += 9;

                        while (a != b) {
                            temp |= g_setMask[a];
                            a += 9;
                        }
                    }

                    bishop_commonAttacks[i][j].used = true;
                    bishop_commonAttacks[i][j].bb = temp;
                }
            }
        }
    }

    return;
}

static void init_rookattacks(void)
{
    int i, j;

    for (i = 0; i < 64; i++) {
        int iFile = FILE(i);
        int iRank = RANK(i);

        for (j = 0; j < 4; j++) {
            int inc = rooksq[j];

            if ((iFile == 0) && (inc == -1)) {
                continue;
            }

            if ((iFile == 7) && (inc == 1)) {
                continue;
            }

            if ((iRank == 0) && (inc == -8)) {
                continue;
            }

            if ((iRank == 7) && (inc == 8)) {
                continue;
            }

            int pos = i + inc;
            g_rook_attacks[i] |= g_setMask[pos];

            while (isRookEdge(inc, pos) == false) {
                pos = pos + inc;
                g_rook_attacks[i] |= g_setMask[pos];
            }
        }
    }

    return;
}

static void init_rookcommonattacks(void)
{
    int i, j;
    (void) memset(rook_commonAttacks, '\0', sizeof(BBOARD) * 64 * 64);

    for (i = 0; i < 64; i++) {
        for (j = 0; j < 64; j++) {
            if (i != j) {
                if (RANK(i) == RANK(j)) {
                    /*
                       Horizontal line
                     */
                    BITBOARD temp = g_rook_attacks[i] & g_rook_attacks[j];
                    int a = meson_min(i, j);
                    int b = meson_max(i, j);

                    while (FILE(a) != 0) {
                        a--;
                        temp &= g_clearMask[a];
                    }

                    while (FILE(b) != 7) {
                        b++;
                        temp &= g_clearMask[b];
                    }

                    rook_commonAttacks[i][j].used = true;
                    rook_commonAttacks[i][j].bb = temp;
                } else if (FILE(i) == FILE(j)) {
                    /*
                       Vertical line
                     */
                    BITBOARD temp = g_rook_attacks[i] & g_rook_attacks[j];
                    int a = meson_min(i, j);
                    int b = meson_max(i, j);

                    while (RANK(a) != 0) {
                        a = a - 8;
                        temp &= g_clearMask[a];
                    }

                    while (RANK(b) != 7) {
                        b = b + 8;
                        temp &= g_clearMask[b];
                    }

                    rook_commonAttacks[i][j].used = true;
                    rook_commonAttacks[i][j].bb = temp;
                }
            }
        }
    }

    return;
}

static void init_pawnmoves(void)
{
    int leftCap;
    int rightCap;
    int firstStep;
    int secondStep;
    int iFile;
    int i;
    enum COLOUR c;

    for (c = WHITE; c <= BLACK; c++) {
        if (c == WHITE) {
            leftCap = 7;
            rightCap = 9;
            firstStep = 8;
            secondStep = 16;
        } else {
            leftCap = -9;
            rightCap = -7;
            firstStep = -8;
            secondStep = -16;
        }

        for (i = 0; i < 8; i++) {
            iFile = FILE(i);

            if (c == WHITE) {
                if (iFile != 0) {
                    g_pawn_attacks[c][i] |= g_setMask[i + leftCap];
                }

                if (iFile != 7) {
                    g_pawn_attacks[c][i] |= g_setMask[i + rightCap];
                }
            }
        }

        for (i = 56; i < 64; i++) {
            iFile = FILE(i);

            if (c == BLACK) {
                if (iFile != 0) {
                    g_pawn_attacks[c][i] |= g_setMask[i + leftCap];
                }

                if (iFile != 7) {
                    g_pawn_attacks[c][i] |= g_setMask[i + rightCap];
                }
            }
        }

        for (i = 8; i < 56; i++) {
            iFile = FILE(i);
            int iRank = RANK(i);

            if (iFile != 0) {
                g_pawn_attacks[c][i] |= g_setMask[i + leftCap];
            }

            if (iFile != 7) {
                g_pawn_attacks[c][i] |= g_setMask[i + rightCap];
            }

            g_pawn_moves[c][i] |= g_setMask[i + firstStep];

            if ((c == WHITE) && (iRank == 1)) {
                g_pawn_moves[c][i] |= g_setMask[i + secondStep];
            }

            if ((c == BLACK) && (iRank == 6)) {
                g_pawn_moves[c][i] |= g_setMask[i + secondStep];
            }
        }
    }

    return;
}
