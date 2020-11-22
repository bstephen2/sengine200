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
INCLIB	=	-I/usr/include/libxml2
HASHDEFS	=	-DHASH_FUNCTION=HASH_OAT
CFLAGS	=	${DEBUG} ${HASHDEFS} ${INCLIB} -c -fopenmp -mtune=native -m${BITS} -Wall -std=gnu11
LDFLAGS	=	-o${EXE} -fopenmp
IND		=	astyle
INDOPTS	=	--style=kr --align-pointer=type --indent=tab=3 --indent=spaces \
				--pad-oper --unpad-paren --break-blocks \
				--pad-header
POOLHDS	=	pool.h
POOLMODS	=	pool.c
POOLOBJS	=	pool.o
POOLASMS	=	pool.asm
MD5HDS	=	md5.h
MD5MODS	=	md5.c
MD5OBJS	=	md5.o
MD5ASMS	=	md5.asm
CHDS		=	sengine.h
CMODS		=	main.c args.c memory.c xml.c init.c board.c boardlist.c direct.c
COBJS		=	main.o args.o memory.o xml.o init.o board.o boardlist.o direct.o
CASMS		=	main.asm args.asm memory.asm xml.asm init.asm board.asm boardlist.asm direct.asm
AHDS		=	sengine.inc
AMODS		=	globals.asm vals.asm asminit.asm
AOBJS		=	globals.o vals.o asminit.o
LIBS		=	-lxml2

sengine200:	${COBJS} ${AOBJS} ${POOLOBJS} ${MD5OBJS}
	${LD}   ${LDFLAGS} ${COBJS} ${AOBJS} ${POOLOBJS} ${MD5OBJS} ${LIBS}
	cp ${EXE} ${HOME}/bin/${EXE}

main.o:	main.c ${CHDS}
	${CC} ${CFLAGS} main.c
	objconv -fnasm main.o

args.o:	args.c ${CHDS}
	${CC} ${CFLAGS} args.c
	objconv -fnasm args.o

memory.o:	memory.c ${CHDS}
	${CC} ${CFLAGS} memory.c
	objconv -fnasm memory.o

xml.o:	xml.c ${CHDS}
	${CC} ${CFLAGS} xml.c
	objconv -fnasm xml.o

board.o:	board.c ${CHDS}
	${CC} ${CFLAGS} board.c
	objconv -fnasm board.o

direct.o:	direct.c ${CHDS}
	${CC} ${CFLAGS} direct.c
	objconv -fnasm direct.o

boardlist.o:	boardlist.c ${CHDS}
	${CC} ${CFLAGS} boardlist.c
	objconv -fnasm boardlist.o

init.o:	init.c ${CHDS}
	${CC} ${CFLAGS} init.c
	objconv -fnasm init.o

pool.o:	pool.c ${POOLHDS}
	${CC} ${CFLAGS} pool.c
	objconv -fnasm pool.o

md5.o:	md5.c ${POOLHDS}
	${CC} ${CFLAGS} md5.c
	objconv -fnasm md5.o

globals.o:	globals.asm ${AHDS}
	${AS} ${AFLAGS} -l globals.lst globals.asm

vals.o:	vals.asm ${AHDS}
	${AS} ${AFLAGS} -l vals.lst vals.asm

asminit.o:	asminit.asm ${AHDS}
	${AS} ${AFLAGS} -l asminit.lst asminit.asm

tags:	${CMODS} ${CHDS}
	ctags ${CMODS} ${CHDS}

clean:
	rm ${COBJS} ${AOBJS} ${CASMS} ${POOLOBJS} ${MD5OBJS} ${POOLASMS} ${MD5ASMS} ${EXE} *orig *lst *a86 tags

tidy:
	${IND} ${INDOPTS} ${CMODS} ${CHDS}

touch:
	touch ${CMODS} ${CHDS} ${AMODS} ${AHDS}
	
count:
	wc -l ${CMODS} ${CHDS} ${AMODS} ${AHDS} | sort -b -n	
