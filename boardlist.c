/*
 *	sengine
 *	A threaded program for solving directmate chess problems.
 *
 *	(c) 2020-2021, Brian Stephenson
 * brian@bstephen.me.uk
 *
 */

#include "sengine.h"

void freeBoard(BOARD*);
bool deepEquals(BOARD*, BOARD*);

static int refutCompare(void*, void*);

void putRefutsToEnd(BOARDLIST* bml)
{
    DL_SORT(bml->vektor, refutCompare);
    return;
}

static int refutCompare(void* a, void* b)
{
    BOARD* aa = (BOARD*) a;
    BOARD* bb = (BOARD*) b;
    int ia;
    int ib;
    ia = (aa->tag == '!') ? 1 : 0;
    ib = (bb->tag == '!') ? 1 : 0;

    if (ia == ib) {
        return 0;
    } else {
        return (ia < ib) ? -1 : 1;
    }
}

bool bListEquals(BOARDLIST* ibl, BOARDLIST* obl)
{
    int counto, counti;
    BOARD* tmp;
    BOARD* tmp1;
    BOARD* a;
    BOARD* b;
    assert(obl != NULL);
    assert(ibl != NULL);
    assert(ibl->moveNumber == obl->moveNumber);
    //assert(obl->vektor != NULL);
    //assert(ibl->vektor != NULL);

    DL_COUNT(ibl->vektor, tmp, counti);
    DL_COUNT(obl->vektor, tmp1, counto);

    if (counti != counto) {
        return false;
    }

    if (counti == 0) {
        return true;
    }

    /*
    a = ibl->vektor->next;
    b = obl->vektor->next;
    */

    a = ibl->vektor;
    b = obl->vektor;

    while (a != NULL) {
        assert(b != NULL);

        if (deepEquals(a, b) == false) {
            return false;
        }

        a = a->next;
        b = b->next;
    }

    return true;
}

void weedOutShortVars(BOARDLIST* ml, unsigned char maxstip)
{
    BOARDLIST* bl;
    BOARD* b;
    BOARD* tmp;
    DL_FOREACH_SAFE(ml->vektor, b, tmp) {
        bl = b->nextply;

        if (bl != NULL) {
            if (bl->stipIn < maxstip) {
                DL_DELETE(ml->vektor, b);
                freeBoard(b);
            }
        }
    }
    return;
}

void weedOutLongVars(BOARDLIST* thisml)
{
    BOARDLIST* ml;
    BOARD* m;
    BOARD* tmp;
    DL_FOREACH_SAFE(thisml->vektor, m, tmp) {
        ml = m->nextply;

        if (ml != NULL) {
            if (ml->stipIn > thisml->minStip) {
                DL_DELETE(thisml->vektor, m);
                freeBoard(m);
            }
        }
    }
    return;
}
