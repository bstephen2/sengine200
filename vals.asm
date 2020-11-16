;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * 	brian@bstephen.me.uk
; *
; */

					%include		'sengine.inc'

					[section    .data]
					;  Initialised data.

cast				db				'KQkq', 0
bad_moves:		db				'sengine200: --moves=%s is invalid', 0
bad_sols:		db				'sengine200: --sols=%s is invalid', 0
bad_refuts:		db				'sengine200: --refuts=%s is invalid', 0
bad_kings:		db				'sengine200: --kings=%s is invalid', 0
bad_gbr:			db				'sengine200: --gbr=%s is invalid', 0
bad_pos:			db				'sengine200: --pos=%is is invalid', 0
bad_castling:	db				'sengine200: --castling=%s is invalid', 0
bad_ep:			db				'sengine200: --ep=%s is invalid', 0
bad_threats:	db				'sengine200: --threats=%s is invalid', 0

					[section 	.bss]
					;  Uninitialised data.

					[section 	.text]
               
					extern		g_kings
					extern		g_gbr
					extern		g_pos
					extern		g_refuts
					extern		g_sols
					extern		g_moves
					extern		g_threats
					extern		g_castling
					extern		g_st_moves
					extern		g_st_sols
					extern		g_st_refuts
					extern		g_st_threats
					extern		stderr
					extern		strlen
					extern		strspn
					extern		fprintf

					global		val_kings
					global		val_gbr
					global		val_pos
					global		val_castling
					global		val_ep
					global		val_moves
					global		val_sols
					global		val_refuts
					global		val_threats

;
;	val_squares
;
;	Input arg (ptr_str) contains a pointer to a string to be validated. A valid string should have an even number of characters
;	and each pair should fit the pattern [a-h][1-8]. No pair should be repeated. A zero-length string is not valid. If valid
;	return 0. If not return 1.
;
					%push       val_squares

val_squares:	equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%arg        ptr_str:dword
					enter       %$localsize, 0
					xor			eax, eax
					leave
					ret
					%pop

;	val_kings
;
;	Global variable g_kings contains a pointer to a string to be validated. A valid string should be valid as per
;	val_squares, have a length of 4 and not contains square that are adjacent. If valid return 0. If no print an error message
;	and return 1.
;
					%push       val_kings

val_kings:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;
;	val_gbr
;
;	Global variable g_gbr contains a pointer to a string to be validated. A valid string fits the pattern
;	'^[0-4][0-8][0-8][0-8]\.[0-8][0-8]$'. If valid, return 0. If not print an error message in stderr and return 1.
;
					%push       val_gbr

val_gbr:			equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;	val_pos
;
;	Global variable g_pos contains a pointer to a string to be validated. If valid return 0, else print error message and
;	return 1. Only validation needed is that carried out by val_squares.
;
					%push       val_pos

val_pos:			equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;	val_castling
;
;	Global variable g_castling contains a pointer to a string to be validated. A null pointer or empty string is valid. A valid
;	string should have a maximum length of 4 and contain only the characters 'K', 'Q', 'k' and 'q' and none of them should
;	be repeated. If valid return 0, else print an error message and return 1.
;
					%push       val_castling

val_castling:	equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
					SAVE			esi
					mov			esi, [g_castling]
					test			esi, esi
					jz				vc_97					;	A null pointer is valid

					push			esi
					call			strlen
					add			esp, 4
					test			eax, eax
					jz				vc_99					;	An empty string is valid
					mov			ecx, eax

					push			cast
					push			esi
					call			strspn
					add			esp, 8
					cmp			eax, ecx
					jne			vc_98					;	Invalid characters present

vc_97:			equ			$					
					xor			eax, eax
					jmp			vc_99

vc_98:			equ			$
					mov			esi, [g_castling]
					push			esi
					mov			esi, bad_castling
					push			esi
					push			dword [stderr]
					call			fprintf
					add			esp, 12
					mov			eax, 1

vc_99:			equ			$
					RESTORE		esi
					leave
					ret
					%pop

;	val_ep
;
;	Global variable g_ep contains a pointer to a string to be validated. A null pointer or empty string is valid. Validate as a
;	string fitting the pattern '^[a-h]5$'. Return 0 if valid. If invalid print error message to stderr and return 1.
;
					%push       val_ep

val_ep:			equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;
;	val_moves
;
;	Global variable g_st_moves contains a pointer to a string to be validated. A null pointer is valid. Validate string as
;	a one-character ascii value between 1 and 9. If valid, set g_moves to its value and return 0. If invalid return 1.
;
					%push       val_moves

val_moves:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
					SAVE			esi
					mov			esi, [g_st_moves]
					test			esi, esi
					jz				vm_98
					lodsw
					test			ah, ah
					jnz			vm_97
					sub			al, '0'
					cmp			al, 1
					jl				vm_97
					cmp			al, 9
					jg				vm_97
					mov			[g_moves], al
              	jmp			vm_98 
vm_97:			equ			$
					mov			esi, [ptr_str]
					push			esi
					mov			esi, bad_moves
					push			esi
					push			dword [stderr]
					call			fprintf
					add			esp, 12
					mov			eax, 1
					jmp			vm_99
vm_98:			equ			$					
					xor			eax, eax
vm_99:			equ			$					
					RESTORE		esi
					leave
					ret
					%pop

;
;	val_sols
;
;	Global variable g_st_sols contains a pointer to string to be validated. A null pointer is valid.	Validate string as
;	a one-character ascii value between 1 and 9. If valid, set g_sols to its value and return 0. If invalid return 1.
;
					%push       val_sols

val_sols:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					enter       %$localsize, 0
					SAVE			esi
					mov			esi, [g_st_sols]
					test			esi, esi
					jz				vs_98
					lodsw
					test			ah, ah
					jnz			vs_97
					sub			al, '0'
					cmp			al, 1
					jl				vs_97
					cmp			al, 9
					jg				vs_97
					mov			[g_sols], al
              	jmp			vs_98 
vs_97:			equ			$
					mov			esi, [ptr_str]
					push			esi
					mov			esi, bad_sols
					push			esi
					push			dword [stderr]
					call			fprintf
					add			esp, 12
					mov			eax, 1
					jmp			vs_99
vs_98:			equ			$					
					xor			eax, eax
vs_99:			equ			$					
					RESTORE		esi
					leave
					ret
					%pop

;
;	val_refuts
;
;	Global variable g_st_refuts contains a pointer to string to be validated. A null pointer is valid.	Validate string as
;	a one-character ascii value between 1 and 9. If valid, set g_refuts to its value and return 0. If invalid return 1.
;
					%push       val_refuts

val_refuts:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%arg        ptr_str:dword
					enter       %$localsize, 0
					SAVE			esi
					mov			esi, [g_st_refuts]
					test			esi, esi
					jz				vr_98
					lodsw
					test			ah, ah
					jnz			vr_97
					sub			al, '0'
					cmp			al, 1
					jl				vr_97
					cmp			al, 9
					jg				vr_97
					mov			[g_refuts], al
              	jmp			vr_98 
vr_97:			equ			$
					mov			esi, [ptr_str]
					push			esi
					mov			esi, bad_refuts
					push			esi
					push			dword [stderr]
					call			fprintf
					add			esp, 12
					mov			eax, 1
					jmp			vr_99
vr_98:			equ			$					
					xor			eax, eax
vr_99:			equ			$					
					RESTORE		esi
					leave
					ret
					%pop

;	val_threats
;
;	Global variable g_st_threats contains a pointer to a string to be validated. If valid set g_threats appropriately and return 0,
;	else print error message and return 1. Valid valuds are 'ALL', 'NONE' and 'SHORTEST'. A null pointer is valid.
;
					%push       val_threats


val_threats:	equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

