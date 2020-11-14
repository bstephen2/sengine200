;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * brian@bstephen.me.uk
; *
; */

					%include		'sengine.inc'

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

					[section			.data]
					;  Initialised data.
					
					align			4
g_kings			dd				0
g_gbr				dd				0
g_pos				dd				0
g_castling		dd				0
g_ep				dd				0
g_moves			db				2
g_sols			db				1
g_refuts			db				1
g_threats		db				THR_SHORTEST
g_hash			db				FALSE
g_help			db				FALSE
g_set				db				FALSE
g_tries			db				FALSE
g_trivtries		db				FALSE
g_actual			db				FALSE	
g_shortvars		db				FALSE
g_fleck			db				FALSE
g_meson			db				FALSE
g_classify		db				FALSE
g_version		db				FALSE

					[section 		.bss]
					;  Uninitialised data.


