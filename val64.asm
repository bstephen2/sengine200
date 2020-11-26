;/*
; *	sengine
; *	A threaded program for solving directmate chess problems.
; *
; *	(c) 2020-2021, Brian Stephenson
; * 	brian@bstephen.me.uk
; *
; */

					%include		'seng64.inc'

					[section    	.data]
					;  Initialised data.

TH_NONE				db				'NONE', 0
TH_ALL				db				'ALL', 0
TH_SHORTEST			db				'SHORTEST', 0
cast				db				'KQkq', 0
bad_moves:			db				'sengine200: --moves=%s is invalid', 0
bad_sols:			db				'sengine200: --sols=%s is invalid', 0
bad_refuts:			db				'sengine200: --refuts=%s is invalid', 0
bad_ep:				db				'sengine200: --ep=%s is invalid', 0
bad_threats:		db				'sengine200: --threats=%s is invalid', 0
bad_gp				db				'sengine200: --gbr and --pos not compatible', 0
bad_vkp				db				'sengine200: square in --kings duplicated in --pos', 0

					[section 		.bss]
					;  Uninitialised data.

					[section 		.text]
               
					extern			strlen
					extern			strspn
					extern			strcmp

					global			val_kings
					global			val_gbr
					global			val_pos
					global			val_castling
					global			val_ep
					global			val_moves
					global			val_sols
					global			val_refuts
					global			val_threats
					global			val_gbr_pos
					global			val_kings_pos

;
;	val_squares
;
;	A valid string should have an even number of characters	and each pair should fit the pattern [a-h][1-8]. No pair
;	should be repeated. A zero-length string is not valid. If valid	return 0. If not return 1.
;
;	INPUT ARGS
;
;	rcx contains the address of the string to be validated.
;
					%push       	val_squares

					align			16
val_squares:		equ         	$
					%stacksize  	flat64
					%assign     	%$localsize 0
					enter       	%$localsize, 0
					SAVE			rsi
					mov				rsi, rcx
;
;	Check for invalid null pointer
;
					test			rsi, rsi
					jz				vsq_98
;
;	Check for invalid zero-length string
;
					mov				al, [rsi]
					cmp				al, 0
					je				vsq_98
;
;	Check all characters
;
vsq_00:				equ				$
					lodsw
					cmp				al, 0				;	end of string?
					je				vsq_01
					cmp				ah, 0				;	string of odd length?
					je				vsq_98
					cmp				al, 'a'
					jb				vsq_98
					cmp				al, 'h'
					ja				vsq_98
					cmp				ah, '1'
					jb				vsq_98
					cmp				ah, '8'
					ja				vsq_98
					jmp				vsq_00
;
;	Check for repeated squares
;
vsq_01:				equ				$
					mov				rsi, rcx

vsq_02:				equ				$					
					mov				al, [rsi + 2]
					cmp				al, 0				;	final square?
					je				vsq_97
					lodsw
					mov				rdx, rsi

vsq_03:				equ				$					
					mov				cx, [rdx]
					cmp				ax, cx				;	repeated square?
					je				vsq_98
					add				rdx, 2
					mov				cl, [rdx]
					cmp				cl, 0				;	end of string?
					jne				vsq_03
					jmp				vsq_02

vsq_97:				equ				$					
					xor				rax, rax
					jmp				vsq_99

vsq_98:				equ				$
					mov				rax, 1

vsq_99:				equ				$					
					RESTORE			rsi
					leave
					ret
					%pop

;	val_kings
;
;	A valid string should be valid as per val_squares, have a length of 4 and not contains square that are adjacent.
;	 If valid return 0. If not print an error message and return 1.
;
;	INPUT ARGS
;
;	rcx contains the address of the string to be validated.
;
					%push       	val_kings

					align			16
val_kings:			equ         	$
					%stacksize  	flat64
					%assign     	%$localsize 0
					%local			rcxsave:qword
					enter       	%$localsize, 0
					SAVE			rsi
					mov				[rcxsave], rcx
					mov				rsi, rcx
					test			rsi, rsi					;	Null pointer?
					jz				vk_98
					call			strlen
					cmp				rax, 4						;	Length of 4?
					jne				vk_98
					call			val_squares
					test			rax, rax					;	Squares valid?
					jnz				vk_98
;
;	Check that squares are not adjacent
;
					mov				rsi, [rcxsave]
					mov				dl, [rsi]
					sub				dl, [rsi + 2]
					BDS_ABS			dl, al
					mov				cl, [rsi + 1]
					sub				cl, [rsi + 3]
					BDS_ABS			cl, al
					cmp				dl, 1
					jne				vk_00
					cmp				cl, 1
					je				vk_98

vk_00:				equ				$
					add				dl, cl
					cmp				dl, 1
					je				vk_98
					xor				rax, rax
					jmp				vk_99

vk_98:				equ				$
					mov				rax, 1

vk_99:				equ				$					
					RESTORE			rsi
					leave
					ret
					%pop
;
;
;	val_gbr
;
;	Input arg in RCX contains a pointer to a string to be validated. A valid string fits the pattern
;	'^[0-4][0-8][0-8][0-8]\.[0-8][0-8]$'. If valid, return 0. If not print an error message in stderr and return 1.
;
					%push       	val_gbr
					
val_gbr:			equ				$
					align			16
					%stacksize  	flat64
					%assign     	%$localsize 0
					enter       	%$localsize, 0
					SAVE			rsi, rbx
					mov				rsi, rcx
					mov				rbx, rcx
;
;	Check length					
;
					call			strlen
					cmp				rax, 7
					jne				vg_98
;
;	Check first character
;
					lodsb
					cmp				al, '0'
					jb				vg_98
					cmp				al, '4'
					ja				vg_98
;
;	Check second character
;
					lodsb
					cmp				al, '0'
					jb				vg_98
					cmp				al, '8'
					ja				vg_98
;
;	Check third character
;
					lodsb
					cmp				al, '0'
					jb				vg_98
					cmp				al, '8'
					ja				vg_98
;
;	Check fourth character
;
					lodsb
					cmp				al, '0'
					jb				vg_98
					cmp				al, '8'
					ja				vg_98
;
;	Check fifth character					
;
					lodsb
					cmp				al, '.'
					jne				vg_98
;
;	Check sixth character
;
					lodsb
					cmp				al, '0'
					jb				vg_98
					cmp				al, '8'
					ja				vg_98

;
;	Check seventh character
;
					lodsb
					cmp				al, '0'
					jb				vg_98
					cmp				al, '8'
					ja				vg_98
					xor				rax, rax
					jmp				vg_99

vg_98:				equ				$
					mov				rax, 1

vg_99:				equ				$					
					RESTORE			rsi, rbx
					leave
					ret
					%pop
;
;	val_pos
;
;	RCX contains a pointer to a string to be validated. If valid return 0, else print error message and
;	return 1. Only validation needed is that carried out by val_squares.
;
					%push       	val_pos

					align			16
					
val_pos:			equ         	$
					%stacksize  	flat64
					%assign     	%$localsize 0
					enter       	%$localsize, 0
					call			val_squares
					test			rax, rax
					jnz				vpo_98
               
					xor				rax, rax
					jmp				vpo_99

vpo_98:				equ				$
					mov				rax, 1

vpo_99:				equ				$					
					leave
					ret
					%pop
;
;	val_castling
;
;	RCX contains a pointer to a string to be validated. A null pointer or empty string is valid. A valid
;	string should have a maximum length of 4 and contain only the characters 'K', 'Q', 'k' and 'q' and none of them should
;	be repeated. If valid return 0, else print an error message and return 1.
;
					%push       	val_castling

					align			16
					
val_castling:		equ         	$
					%stacksize  	flat64
					%assign     	%$localsize 0
					enter       	%$localsize, 0
					SAVE			rsi, rbx
					mov				rsi, rcx
					test			rsi, rsi
					jz				vc_97					;	A null pointer is valid

					call			strlen
					test			rax, rax
					jz				vc_99					;	An empty string is valid
					mov				rbx, rax

					mov				rcx, rsi
					mov				rdx, cast
					call			strspn
					cmp				rax, rbx
					jne				vc_98					;	Invalid characters present

vc_00:				equ				$					
					lodsb
					cmp				al, 0
					je				vc_97
					mov				rdx, rsi

vc_01:				equ				$					
					mov				ah, [rdx]
					cmp				ah, 0
					je				vc_00
					cmp				ah, al
					je				vc_98					;	Repeated character
					add				rdx, 1
					jmp				vc_01

vc_97:				equ				$					
					xor				rax, rax
					jmp				vc_99

vc_98:				equ				$
					mov				rax, 1

vc_99:				equ				$
					RESTORE			rsi, rbx
					leave
					ret
					%pop
;
;;	val_ep
;;
;;	Global variable g_ep contains a pointer to a string to be validated. A null pointer or empty string is valid. Validate as a
;;	string fitting the pattern '^[a-h]5$'. Return 0 if valid. If invalid print error message to stderr and return 1.
;;
;					%push       	val_ep
;
;					align			16
;					
;val_ep:				equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter       	%$localsize, 0
;					SAVE			rsi
;					mov				rsi, [g_ep]
;					test			rsi, rsi
;					jz				vp_99					;	Null pointer is ok
;					lodsb
;					cmp				al, 0
;					je				vp_99					;	Empty string is ok
;					cmp				al, 'a'
;					jb				vp_98
;					cmp				al, 'h'
;					jg				vp_98
;					lodsb									;	First character valid
;					cmp				al, '5'
;					jne				vp_98					;	Second character not valid
;					lodsb
;					cmp				al, 0
;					jne				vp_98					;	Not end of string - invalid
;					jmp				vp_99
;
;vp_98:				equ				$
;					mov				rcx, [stderr]
;					mov				rdx, bad_ep
;					mov				r8, [g_ep]
;					call			fprintf
;					mov				rax, 1
;					jmp				vp_100
;
;vp_99:				equ				$
;					xor				rax, rax
;
;vp_100:				equ				$
;					RESTORE			rsi
;					leave
;					ret
;					%pop
;
;;
;;	val_moves
;;
;;	Global variable g_st_moves contains a pointer to a string to be validated. A null pointer is valid. Validate string as
;;	a one-character ascii value between 1 and 9. If valid, set g_moves to its value and return 0. If invalid return 1.
;;
;					%push       	val_moves
;
;					align			16
;					
;val_moves:			equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter       	%$localsize, 0
;					SAVE			rsi
;					mov				rsi, [g_st_moves]
;					test			rsi, rsi
;					jz				vm_98
;					lodsw
;					test			ah, ah
;					jnz				vm_97
;					sub				al, '0'
;					cmp				al, 1
;					jl				vm_97
;					cmp				al, 9
;					jg				vm_97
;					mov				[g_moves], al
;					jmp				vm_98
;					
;vm_97:				equ				$
;					mov				rcx, [stderr]
;					mov				rdx, bad_moves
;					mov				r8, [g_st_moves]
;					call			fprintf
;					mov				rax, 1
;					jmp				vm_99
;					
;vm_98:				equ				$					
;					xor				rax, rax
;					
;vm_99:				equ				$					
;					RESTORE			rsi
;					leave
;					ret
;					%pop
;
;;
;;	val_sols
;;
;;	Global variable g_st_sols contains a pointer to string to be validated. A null pointer is valid.	Validate string as
;;	a one-character ascii value between 1 and 9. If valid, set g_sols to its value and return 0. If invalid return 1.
;;
;					%push       	val_sols
;
;					align			16
;					
;val_sols:			equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter       	%$localsize, 0
;					SAVE			rsi
;					mov				rsi, [g_st_sols]
;					test			rsi, rsi
;					jz				vs_98
;					lodsw
;					test			ah, ah
;					jnz				vs_97
;					sub				al, '0'
;					cmp				al, 1
;					jl				vs_97
;					cmp				al, 9
;					jg				vs_97
;					mov				[g_sols], al
;					jmp				vs_98
;					
;vs_97:				equ				$
;					mov				rcx, [stderr]
;					mov				rdx, bad_sols
;					mov				r8, [g_st_sols]
;					call			fprintf
;					mov				rax, 1
;					jmp				vs_99
;					
;vs_98:				equ				$					
;					xor				rax, rax
;					
;vs_99:				equ				$					
;					RESTORE			rsi
;					leave
;					ret
;					%pop
;
;;
;;	val_refuts
;;
;;	Global variable g_st_refuts contains a pointer to string to be validated. A null pointer is valid.	Validate string as
;;	a one-character ascii value between 1 and 9. If valid, set g_refuts to its value and return 0. If invalid return 1.
;;
;					%push       	val_refuts
;
;					align			16
;val_refuts:			equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter       	%$localsize, 0
;					SAVE			rsi
;					mov				rsi, [g_st_refuts]
;					test			rsi, rsi
;					jz				vr_98
;					lodsw
;					test			ah, ah
;					jnz				vr_97
;					sub				al, '0'
;					cmp				al, 1
;					jl				vr_97
;					cmp				al, 9
;					jg				vr_97
;					mov				[g_refuts], al
;					jmp				vr_98
;					
;vr_97:				equ				$
;					mov				rcx, [stderr]
;					mov				rdx, bad_refuts
;					mov				r8, [g_st_refuts]
;					call			fprintf
;					mov				rax, 1
;					jmp				vr_99
;					
;vr_98:				equ				$					
;					xor				rax, rax
;					
;vr_99:				equ				$					
;					RESTORE			rsi
;					leave
;					ret
;					%pop
;
;;	val_threats
;;
;;	Global variable g_st_threats contains a pointer to a string to be validated. If valid set g_threats appropriately and return 0,
;;	else print error message and return 1. Valid valuds are 'ALL', 'NONE' and 'SHORTEST'. A null pointer is valid.
;;
;					%push       	val_threats
;
;
;					align			16
;					
;val_threats:		equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter      		%$localsize, 0
;					SAVE			rsi
;					mov				rsi, [g_st_threats]
;;
;;	Check for null pointer
;;
;					test			rsi, rsi
;					jz				vt_97
;;
;;	Check for empty string
;;
;					mov				al, [rsi]
;					cmp				al, 0
;					jz				vt_97
;;
;;	Check for valid strings
;;
;					mov				rcx, rsi
;					mov				rdx, TH_ALL
;					call			strcmp
;					test			rax, rax
;					jnz				vt_00
;					mov				eax, THR_ALL
;					mov				[g_threats], eax
;					jmp				vt_97
;
;vt_00:				equ				$					
;					mov				rcx, rsi
;					mov				rdx, TH_NONE
;					call			strcmp
;					test			rax, rax
;					jnz				vt_01
;					mov				eax, THR_NONE
;					mov				[g_threats], eax 
;					jmp				vt_97
;
;vt_01:				equ				$
;					mov				rcx, rsi
;					mov				rdx, TH_SHORTEST
;					call			strcmp
;					test			rax, rax
;					jnz				vt_98
;					mov				eax, THR_SHORTEST
;					mov				[g_threats], eax
;
;vt_97:				equ				$					
;					xor				rax, rax
;					jmp				vt_99
;
;vt_98:				equ				$
;					mov				rcx, [stderr]
;					mov				rdx, bad_threats
;					mov				r8, [g_st_threats]
;					call			fprintf
;					mov				rax, 1
;
;vt_99:				equ				$					
;					RESTORE			rsi
;					leave
;					ret
;					%pop
;
;;
;;	val_kings_pos
;;
;;	Check that no square in g_kings (input arg pointer in RCX) is repeated in g_pos (input arg pointer in RDX)
;;
;					%push       	val_kings_pos
;
;					align			16
;			   
;val_kings_pos:		equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter       	%$localsize, 0
;					SAVE			rsi
;					mov				rsi, rdx
;					mov				rdx, rcx
;					mov				rbx, rsi
;;
;;	Check white king square
;;
;					mov				cx, [rdx]
;
;vkp_00:				equ				$
;					lodsw
;					cmp				al, 0
;					je				vkp_01
;					cmp				cx, ax
;					je				vkp_98
;					jmp				vkp_00
;;
;;	Check black king square
;;
;vkp_01:				equ				$					
;					mov				cx, [rdx + 2]
;					mov				rsi, rbx
;
;vkp_02:				equ				$					
;					lodsw
;					cmp				al, 0
;					je				vkp_03
;					cmp				cx, ax
;					je				vkp_98
;					jmp				vkp_02
;
;vkp_03				equ				$
;					xor				rax, rax
;					jmp				vkp_99
;
;vkp_98:				equ				$
;					mov				rcx, bad_vkp
;					mov				rdx, [stderr]
;					call			fputs
;					mov				rax, 1
;					
;vkp_99:				equ				$
;					RESTORE			rsi
;					leave
;					ret
;					%pop
;
;					%push       	val_gbr_pos
;;
;;	val_gbr_pos
;;
;;	Check that the number of non-royal pieces defined by g_gbr equals the number of squares in g_pos. RCX
;;	contains pointer to g_gbr and RDX contains pointer to g_pos.
;;
;					align			16
;					
;val_gbr_pos:		equ         	$
;					%stacksize  	flat64
;					%assign     	%$localsize 0
;					enter      		%$localsize, 0
;					SAVE			rsi, rbx
;					mov				rsi, rcx
;					mov				rbx, rdx
;					xor				cl, cl
;					mov				dl, 3
;;
;;	Process first four characters of gbr
;;
;vgp_00:				equ				$
;					lodsb
;					cmp				al, '.'
;					je				vgp_01
;					sub				al, '0'
;					movzx			ax, al	
;					div				dl
;					add				cl, al
;					add				cl, ah
;					jmp				vgp_00
;
;;
;;	Process sixth and seventh characters of gbr
;;
;vgp_01:				equ				$
;					lodsb
;					sub				al, '0'
;					add				cl, al
;					lodsb
;					sub				al, '0'
;					add				cl, al
;					movzx			rcx, cl
;					shl				rcx, 1
;;
;;	Check that twice the calculated length of g_pos equals actual length of g_pos
;;
;					mov				rsi, rcx
;					mov				rcx, rbx
;					call			strlen
;					cmp				rax, rsi
;					jne				vgp_98
;
;					xor				rax, rax
;					jmp				vgp_99
;					
;vgp_98:				equ				$
;					mov				rcx, bad_gp
;					mov				rdx, [stderr]
;					call			fputs
;					mov				rax, 1
;					
;vgp_99:				equ				$
;					RESTORE			rsi, rbx
;					leave
;					ret
;					%pop
;
