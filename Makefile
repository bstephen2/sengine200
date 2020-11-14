# Sengine200
# LINUX32 version
BITS		=	32
EXE		=	sengine200
AS			=	nasm
ADEBUG	=	-g -Fdwarf
ARELEASE	=	#-O3
AFLAGS	=	-f elf${BITS} ${DEBUG} ${RELEASE} -g
CC			=	gcc
LD			=	gcc
RELEASE	=	-O3 -DNDEBUG
DEBUG		=	-g -O0 
CFLAGS	=	${DEBUG} -c -mtune=native -m${BITS} -Wall -std=gnu11
LDFLAGS	=	-o${EXE} -fopenmp
IND		=	astyle
INDOPTS	=	--style=kr --align-pointer=type --indent=tab=3 --indent=spaces \
				--pad-oper --unpad-paren --break-blocks \
				--pad-header
CHDS		=	sengine.h
CMODS		=	main.c args.c
COBJS		=	main.o args.o
CASMS		=	main.asm
AHDS		=	sengine.inc
AMODS		=	globals.asm
AOBJS		=	globals.o

sengine200:	${COBJS} ${AOBJS}
	${LD}   ${LDFLAGS} ${COBJS} ${AOBJS}
	cp ${EXE} ${HOME}/bin/${EXE}

main.o:	main.c ${CHDS}
	${CC} ${CFLAGS} main.c
	objconv -fnasm main.o

args.o:	args.c ${CHDS}
	${CC} ${CFLAGS} args.c
	objconv -fnasm args.o

globals.o:	globals.asm ${AHDS}
	${AS} ${AFLAGS} -l globals.lst globals.asm

clean:
	rm ${COBJS} ${AOBJS} ${CASMS} ${EXE} *orig *lst

tidy:
	${IND} ${INDOPTS} ${CMODS} ${CHDS}

touch:
	touch ${CMODS} ${CHDS} ${AMODS}
	
count:
	wc -l ${CMODS} ${CHDS} ${AMODS} | sort -b -n	
