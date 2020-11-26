;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * brian@bstephen.me.uk
; *
; */

								%include		'seng64.inc'

								global		g_setMask
								global		g_clearMask
								global		g_king_attacks
								global		g_knight_attacks
								global		g_bishop_attacks
								global		g_rook_attacks
								global		g_pawn_moves
								global		g_pawn_attacks

								[section			.data]
								;  Initialised data.
					
								align			8
g_setMask				   		SET_SET_MASKS
g_clearMask				   		SET_CLEAR_MASKS
g_king_attacks			   		TIMES 64 dq 0
g_knight_attacks		   		TIMES 64 dq 0
g_bishop_attacks		   		TIMES 64 dq 0
g_rook_attacks			   		TIMES 64 dq 0
g_pawn_moves			   		TIMES 2*64 dq 0
g_pawn_attacks			   		TIMES 2*64 dq 0

								[section 		.bss]
								;  Uninitialised data.


