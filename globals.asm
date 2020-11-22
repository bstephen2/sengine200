;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * brian@bstephen.me.uk
; *
; */

								%include		'sengine.inc'

								global		g_setMask
								global		g_clearMask
								global		g_king_attacks
								global		g_knight_attacks
								global		g_bishop_attacks
								global		g_rook_attacks
								global		g_pawn_moves
								global		g_pawn_attacks
								global		g_kings
								global		g_gbr	
								global		g_pos
								global		g_castling
								global		g_ep
								global		g_moves
								global		g_sols
								global		g_refuts
								global		g_threats
								global		g_hash
								global		g_help
								global		g_set
								global		g_tries
								global		g_trivtries
								global		g_actual
								global		g_shortvars
								global		g_fleck
								global		g_meson
								global		g_classify
								global		g_version
								global		g_st_moves
								global		g_st_sols
								global		g_st_refuts
								global		g_st_threats

								[section			.data]
								;  Initialised data.
					
								align			8
g_setMask				   SET_SET_MASKS
g_clearMask				   SET_CLEAR_MASKS
g_king_attacks			   TIMES 64 dq 0
g_knight_attacks		   TIMES 64 dq 0
g_bishop_attacks		   TIMES 64 dq 0
g_rook_attacks			   TIMES 64 dq 0
g_pawn_moves			   TIMES 2*64 dq 0
g_pawn_attacks			   TIMES 2*64 dq 0

g_kings						dd				0
g_gbr							dd				0
g_pos							dd				0
g_castling					dd				0
g_ep							dd				0

g_st_moves					dd				0
g_st_sols					dd				0
g_st_refuts					dd				0
g_st_threats				dd				0

g_threats					dd				THR_SHORTEST
g_moves						db				2
g_sols						db				1
g_refuts						db				0
g_hash						db				FALSE
g_help						db				FALSE
g_set							db				FALSE
g_tries						db				FALSE
g_trivtries					db				FALSE
g_actual						db				FALSE	
g_shortvars					db				FALSE
g_fleck						db				FALSE
g_meson						db				FALSE
g_classify					db				FALSE
g_version					db				FALSE

								[section 		.bss]
								;  Uninitialised data.


