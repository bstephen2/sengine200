;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * brian@bstephen.me.uk
; *
; */

					[section    .data]
					;  Initialised data.

bad_moves:		db				'sengine200: --moves=%s is invalid', 0
bad_sols:		db				'sengine200: --sols=%s is invalid', 0
bad_refuts:		db				'sengine200: --refuts=%s is invalid', 0

					[section 	.bss]
					;  Uninitialised data.

					[section 	.text]
               
					extern		g_refuts
					extern		g_sols
					extern		g_moves
					extern		g_threats
					extern		stderr
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
;	Input arg (ptr_str) points to a string to be validated. If valid return 0, else print error message to stderr and return
;	1. String should have an even number of characters and each pair should fit the pattern [a-h][1-8]. No pair should be
;	repeated. A zero-length string is not valid.
;
					%push       val_squares

val_squares:	equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;	val_kings
;
;	Input arg (ptr_str) points to a string to be validated. If valid return 0, else print error message to stderr and return
;	1. String should be valid per val_squares and have a length of 4.
;
					%push       val_kings

val_kings:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;
;	val_gbr
;
;	Input arg (ptr_str) points to a string to be validated. If valid return 0, else print error message to stderr and return
;	1. The string should fit the pattern '^[0-4][0-8][0-8][0-8]\.[0-8][0-8]$'.
;
					%push       val_gbr

val_gbr:			equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;	val_pos
;
;	Input arg (ptr_str) points to a string to be validated. If valid return 0, else print error message to stderr and return
;	1. All validation to be carried out be val_squares.
;
					%push       val_pos

val_pos:			equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;	val_castling
;
;	Input arg (ptr_str) points to a string to be validated. If valid return 0, else print error message to stderr and return
;	1. The string should have a maximum length of 4 and contain only the character 'K', 'Q', 'k' and 'q' and none of them
;	should be repeated. A NULL pointer or an empty string is valid.
;
					%push       val_castling


val_castling:	equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;	val_ep
;
;	Input arg (ptr_str) points to a string to be validated. If valid return 0, else print error message to stderr and return
;	1. The string should fit the pattern '^[a-h]5$'. A NULL pointer or an empty string is valid.
;
					%push       val_ep

val_ep:			equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop

;
;	val_moves
;
;	If input arg is null return 0. Else validate input arg as a one-character ascii value between 1 and 9. If valid,
;	set g_moves and return 0. If invalid return 1.
;
					%push       val_moves

val_moves:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%arg        ptr_str:dword
					enter       %$localsize, 0
					push			esi
					mov			esi, [ptr_str]
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
					pop			esi
					leave
					ret
					%pop

;
;	val_sols
;
;	If input arg is null return 0. Else validate input arg as a one-character ascii value between 1 and 9. If valid,
;	set g_sols and return 0. If invalid return 1.
;
					%push       val_sols

val_sols:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%arg        ptr_str:dword
					enter       %$localsize, 0
					push			esi
					mov			esi, [ptr_str]
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
					pop			esi
					leave
					ret
					%pop

;
;	val_refuts
;
;	If input arg is null return 0. Else validate input arg as a one-character ascii value between 1 and 9. If valid,
;	set g_refuts and return 0. If invalid return 1.
;
					%push       val_refuts

val_refuts:		equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%arg        ptr_str:dword
					enter       %$localsize, 0
					push			esi
					mov			esi, [ptr_str]
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
					pop			esi
					leave
					ret
					%pop

;	val_threats
;
;	Input arg (ptr_str) points to a string to be validated. If valid set g_threats appropriately and return 0, else print
;	error message and return 1. Valid valuds are 'ALL', 'NONE' and 'SHORTEST'.
;
					%push       val_threats


val_threats:	equ         $
					%stacksize  flat
					%assign     %$localsize 0
					%local		rc:dword
					%arg        ptr_str:dword
					enter       %$localsize, 0
               
					xor			eax, eax
					leave
					ret
					%pop
