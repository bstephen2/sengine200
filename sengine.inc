;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * brian@bstephen.me.uk
; *
; */

TRUE				EQU			1
FALSE				EQU			0
THR_ALL			EQU			0
THR_NONE			EQU			1
THR_SHORTEST	EQU			2

%macro			SAVE 1-*
	%rep	%0
					push	%1
	%rotate 1
	%endrep
%endmacro

%macro			RESTORE 1-*
	%rep	%0
	%rotate -1
					pop	%1
	%endrep
%endmacro

%macro			ABS	2
					mov	%2, %1
					add	%2, %2
					sbb	%2, %2
					xor	%1, %2
					sub	%1, %2
%endmacro

