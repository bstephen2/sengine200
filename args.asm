; Disassembly of file: args.o
; Sat Nov 14 15:48:42 2020
; Type: ELF32
; Syntax: NASM
; Instruction set: 80386


global do_usage: function
global process_args: function

extern getopt_long_only                                 ; near
extern g_version                                        ; byte
extern g_classify                                       ; byte
extern g_meson                                          ; byte
extern g_fleck                                          ; byte
extern g_shortvars                                      ; byte
extern g_actual                                         ; byte
extern g_trivtries                                      ; byte
extern g_tries                                          ; byte
extern g_set                                            ; byte
extern g_help                                           ; byte
extern g_hash                                           ; byte
extern fwrite                                           ; near
extern stderr                                           ; dword


SECTION .text   align=1 execute                         ; section number 1, code

do_usage:; Function begin
        push    ebp                                     ; 0000 _ 55
        mov     ebp, esp                                ; 0001 _ 89. E5
        sub     esp, 24                                 ; 0003 _ 83. EC, 18
        mov     eax, dword [stderr]                     ; 0006 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 000B _ 89. 44 24, 0C
        mov     dword [esp+8H], 15                      ; 000F _ C7. 44 24, 08, 0000000F
        mov     dword [esp+4H], 1                       ; 0017 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_016                      ; 001F _ C7. 04 24, 00000000(d)
        call    fwrite                                  ; 0026 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 002B _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0030 _ 89. 44 24, 0C
        mov     dword [esp+8H], 46                      ; 0034 _ C7. 44 24, 08, 0000002E
        mov     dword [esp+4H], 1                       ; 003C _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_017                      ; 0044 _ C7. 04 24, 00000010(d)
        call    fwrite                                  ; 004B _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0050 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0055 _ 89. 44 24, 0C
        mov     dword [esp+8H], 43                      ; 0059 _ C7. 44 24, 08, 0000002B
        mov     dword [esp+4H], 1                       ; 0061 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_018                      ; 0069 _ C7. 04 24, 00000040(d)
        call    fwrite                                  ; 0070 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0075 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 007A _ 89. 44 24, 0C
        mov     dword [esp+8H], 29                      ; 007E _ C7. 44 24, 08, 0000001D
        mov     dword [esp+4H], 1                       ; 0086 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_019                      ; 008E _ C7. 04 24, 0000006C(d)
        call    fwrite                                  ; 0095 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 009A _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 009F _ 89. 44 24, 0C
        mov     dword [esp+8H], 54                      ; 00A3 _ C7. 44 24, 08, 00000036
        mov     dword [esp+4H], 1                       ; 00AB _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_020                      ; 00B3 _ C7. 04 24, 0000008C(d)
        call    fwrite                                  ; 00BA _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 00BF _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 00C4 _ 89. 44 24, 0C
        mov     dword [esp+8H], 58                      ; 00C8 _ C7. 44 24, 08, 0000003A
        mov     dword [esp+4H], 1                       ; 00D0 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_021                      ; 00D8 _ C7. 04 24, 000000C4(d)
        call    fwrite                                  ; 00DF _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 00E4 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 00E9 _ 89. 44 24, 0C
        mov     dword [esp+8H], 65                      ; 00ED _ C7. 44 24, 08, 00000041
        mov     dword [esp+4H], 1                       ; 00F5 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_022                      ; 00FD _ C7. 04 24, 00000100(d)
        call    fwrite                                  ; 0104 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0109 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 010E _ 89. 44 24, 0C
        mov     dword [esp+8H], 58                      ; 0112 _ C7. 44 24, 08, 0000003A
        mov     dword [esp+4H], 1                       ; 011A _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_023                      ; 0122 _ C7. 04 24, 00000144(d)
        call    fwrite                                  ; 0129 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 012E _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0133 _ 89. 44 24, 0C
        mov     dword [esp+8H], 80                      ; 0137 _ C7. 44 24, 08, 00000050
        mov     dword [esp+4H], 1                       ; 013F _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_024                      ; 0147 _ C7. 04 24, 00000180(d)
        call    fwrite                                  ; 014E _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0153 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0158 _ 89. 44 24, 0C
        mov     dword [esp+8H], 76                      ; 015C _ C7. 44 24, 08, 0000004C
        mov     dword [esp+4H], 1                       ; 0164 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_025                      ; 016C _ C7. 04 24, 000001D4(d)
        call    fwrite                                  ; 0173 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0178 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 017D _ 89. 44 24, 0C
        mov     dword [esp+8H], 51                      ; 0181 _ C7. 44 24, 08, 00000033
        mov     dword [esp+4H], 1                       ; 0189 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_026                      ; 0191 _ C7. 04 24, 00000224(d)
        call    fwrite                                  ; 0198 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 019D _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 01A2 _ 89. 44 24, 0C
        mov     dword [esp+8H], 46                      ; 01A6 _ C7. 44 24, 08, 0000002E
        mov     dword [esp+4H], 1                       ; 01AE _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_027                      ; 01B6 _ C7. 04 24, 00000258(d)
        call    fwrite                                  ; 01BD _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 01C2 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 01C7 _ 89. 44 24, 0C
        mov     dword [esp+8H], 39                      ; 01CB _ C7. 44 24, 08, 00000027
        mov     dword [esp+4H], 1                       ; 01D3 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_028                      ; 01DB _ C7. 04 24, 00000288(d)
        call    fwrite                                  ; 01E2 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 01E7 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 01EC _ 89. 44 24, 0C
        mov     dword [esp+8H], 36                      ; 01F0 _ C7. 44 24, 08, 00000024
        mov     dword [esp+4H], 1                       ; 01F8 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_029                      ; 0200 _ C7. 04 24, 000002B0(d)
        call    fwrite                                  ; 0207 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 020C _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0211 _ 89. 44 24, 0C
        mov     dword [esp+8H], 42                      ; 0215 _ C7. 44 24, 08, 0000002A
        mov     dword [esp+4H], 1                       ; 021D _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_030                      ; 0225 _ C7. 04 24, 000002D8(d)
        call    fwrite                                  ; 022C _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0231 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0236 _ 89. 44 24, 0C
        mov     dword [esp+8H], 42                      ; 023A _ C7. 44 24, 08, 0000002A
        mov     dword [esp+4H], 1                       ; 0242 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_031                      ; 024A _ C7. 04 24, 00000304(d)
        call    fwrite                                  ; 0251 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 0256 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 025B _ 89. 44 24, 0C
        mov     dword [esp+8H], 45                      ; 025F _ C7. 44 24, 08, 0000002D
        mov     dword [esp+4H], 1                       ; 0267 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_032                      ; 026F _ C7. 04 24, 00000330(d)
        call    fwrite                                  ; 0276 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 027B _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 0280 _ 89. 44 24, 0C
        mov     dword [esp+8H], 83                      ; 0284 _ C7. 44 24, 08, 00000053
        mov     dword [esp+4H], 1                       ; 028C _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_033                      ; 0294 _ C7. 04 24, 00000360(d)
        call    fwrite                                  ; 029B _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 02A0 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 02A5 _ 89. 44 24, 0C
        mov     dword [esp+8H], 66                      ; 02A9 _ C7. 44 24, 08, 00000042
        mov     dword [esp+4H], 1                       ; 02B1 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_034                      ; 02B9 _ C7. 04 24, 000003B4(d)
        call    fwrite                                  ; 02C0 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 02C5 _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 02CA _ 89. 44 24, 0C
        mov     dword [esp+8H], 37                      ; 02CE _ C7. 44 24, 08, 00000025
        mov     dword [esp+4H], 1                       ; 02D6 _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_035                      ; 02DE _ C7. 04 24, 000003F8(d)
        call    fwrite                                  ; 02E5 _ E8, FFFFFFFC(rel)
        mov     eax, dword [stderr]                     ; 02EA _ A1, 00000000(d)
        mov     dword [esp+0CH], eax                    ; 02EF _ 89. 44 24, 0C
        mov     dword [esp+8H], 44                      ; 02F3 _ C7. 44 24, 08, 0000002C
        mov     dword [esp+4H], 1                       ; 02FB _ C7. 44 24, 04, 00000001
        mov     dword [esp], ?_036                      ; 0303 _ C7. 04 24, 00000420(d)
        call    fwrite                                  ; 030A _ E8, FFFFFFFC(rel)
        nop                                             ; 030F _ 90
        leave                                           ; 0310 _ C9
        ret                                             ; 0311 _ C3
; do_usage End of function

process_args:; Function begin
        push    ebp                                     ; 0312 _ 55
        mov     ebp, esp                                ; 0313 _ 89. E5
        push    edi                                     ; 0315 _ 57
        push    esi                                     ; 0316 _ 56
        push    ebx                                     ; 0317 _ 53
        sub     esp, 396                                ; 0318 _ 81. EC, 0000018C
        mov     dword [ebp-170H], 0                     ; 031E _ C7. 85, FFFFFE90, 00000000
        mov     dword [ebp-174H], 0                     ; 0328 _ C7. 85, FFFFFE8C, 00000000
        lea     edx, [ebp-168H]                         ; 0332 _ 8D. 95, FFFFFE98
        mov     ebx, ?_038                              ; 0338 _ BB, 000004E0(d)
        mov     eax, 84                                 ; 033D _ B8, 00000054
        mov     edi, edx                                ; 0342 _ 89. D7
        mov     esi, ebx                                ; 0344 _ 89. DE
        mov     ecx, eax                                ; 0346 _ 89. C1
        rep movsd                                       ; 0348 _ F3: A5
        jmp     ?_015                                   ; 034A _ EB, 7E

?_001:  mov     eax, dword [ebp-16CH]                   ; 034C _ 8B. 85, FFFFFE94
        sub     eax, 97                                 ; 0352 _ 83. E8, 61
        cmp     eax, 19                                 ; 0355 _ 83. F8, 13
        ja      ?_013                                   ; 0358 _ 77, 6C
        mov     eax, dword [?_039+eax*4]                ; 035A _ 8B. 04 85, 00000630(d)
        jmp     eax                                     ; 0361 _ FF. E0

?_002:  mov     byte [g_hash], 1                        ; 0363 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 036A _ EB, 5E

?_003:  mov     byte [g_help], 1                        ; 036C _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 0373 _ EB, 55

?_004:  mov     byte [g_set], 1                         ; 0375 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 037C _ EB, 4C

?_005:  mov     byte [g_tries], 1                       ; 037E _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 0385 _ EB, 43

?_006:  mov     byte [g_trivtries], 1                   ; 0387 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 038E _ EB, 3A

?_007:  mov     byte [g_actual], 1                      ; 0390 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 0397 _ EB, 31

?_008:  mov     byte [g_shortvars], 1                   ; 0399 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 03A0 _ EB, 28

?_009:  mov     byte [g_fleck], 1                       ; 03A2 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 03A9 _ EB, 1F

?_010:  mov     byte [g_meson], 1                       ; 03AB _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 03B2 _ EB, 16

?_011:  mov     byte [g_classify], 1                    ; 03B4 _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 03BB _ EB, 0D

?_012:  mov     byte [g_version], 1                     ; 03BD _ C6. 05, 00000000(d), 01
        jmp     ?_015                                   ; 03C4 _ EB, 04

?_013:  nop                                             ; 03C6 _ 90
        jmp     ?_015                                   ; 03C7 _ EB, 01

?_014:  nop                                             ; 03C9 _ 90
?_015:  lea     eax, [ebp-174H]                         ; 03CA _ 8D. 85, FFFFFE8C
        mov     dword [esp+10H], eax                    ; 03D0 _ 89. 44 24, 10
        lea     eax, [ebp-168H]                         ; 03D4 _ 8D. 85, FFFFFE98
        mov     dword [esp+0CH], eax                    ; 03DA _ 89. 44 24, 0C
        mov     dword [esp+8H], ?_037                   ; 03DE _ C7. 44 24, 08, 0000044D(d)
        mov     eax, dword [ebp+0CH]                    ; 03E6 _ 8B. 45, 0C
        mov     dword [esp+4H], eax                     ; 03E9 _ 89. 44 24, 04
        mov     eax, dword [ebp+8H]                     ; 03ED _ 8B. 45, 08
        mov     dword [esp], eax                        ; 03F0 _ 89. 04 24
        call    getopt_long_only                        ; 03F3 _ E8, FFFFFFFC(rel)
        mov     dword [ebp-16CH], eax                   ; 03F8 _ 89. 85, FFFFFE94
        cmp     dword [ebp-16CH], -1                    ; 03FE _ 83. BD, FFFFFE94, FF
        jne     ?_001                                   ; 0405 _ 0F 85, FFFFFF41
        mov     eax, dword [ebp-170H]                   ; 040B _ 8B. 85, FFFFFE90
        add     esp, 396                                ; 0411 _ 81. C4, 0000018C
        pop     ebx                                     ; 0417 _ 5B
        pop     esi                                     ; 0418 _ 5E
        pop     edi                                     ; 0419 _ 5F
        pop     ebp                                     ; 041A _ 5D
        ret                                             ; 041B _ C3
; process_args End of function


SECTION .data   align=1 noexecute                       ; section number 2, data


SECTION .bss    align=1 noexecute                       ; section number 3, bss


SECTION .rodata align=32 noexecute                      ; section number 4, const

?_016:                                                  ; byte
        db 55H, 53H, 41H, 47H, 45H, 3AH, 20H, 73H       ; 0000 _ USAGE: s
        db 65H, 6EH, 67H, 69H, 6EH, 65H, 0AH, 00H       ; 0008 _ engine..

?_017:                                                  ; byte
        db 20H, 2DH, 2DH, 6BH, 69H, 6EH, 67H, 73H       ; 0010 _  --kings
        db 3DH, 73H, 20H, 20H, 20H, 20H, 20H, 20H       ; 0018 _ =s      
        db 20H, 20H, 20H, 20H, 6BH, 69H, 6EH, 67H       ; 0020 _     king
        db 20H, 70H, 6FH, 73H, 69H, 74H, 69H, 6FH       ; 0028 _  positio
        db 6EH, 73H, 20H, 2DH, 20H, 65H, 67H, 2EH       ; 0030 _ ns - eg.
        db 20H, 61H, 31H, 62H, 34H, 0AH, 00H, 00H       ; 0038 _  a1b4...

?_018:                                                  ; byte
        db 20H, 2DH, 2DH, 67H, 62H, 72H, 3DH, 73H       ; 0040 _  --gbr=s
        db 20H, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 0048 _         
        db 20H, 20H, 20H, 20H, 47H, 42H, 52H, 20H       ; 0050 _     GBR 
        db 63H, 6FH, 64H, 65H, 20H, 2DH, 20H, 65H       ; 0058 _ code - e
        db 67H, 2EH, 20H, 31H, 38H, 38H, 38H, 2EH       ; 0060 _ g. 1888.
        db 32H, 33H, 0AH, 00H                           ; 0068 _ 23..

?_019:                                                  ; byte
        db 20H, 2DH, 2DH, 70H, 6FH, 73H, 3DH, 73H       ; 006C _  --pos=s
        db 20H, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 0074 _         
        db 20H, 20H, 20H, 20H, 70H, 6FH, 73H, 69H       ; 007C _     posi
        db 74H, 69H, 6FH, 6EH, 0AH, 00H, 00H, 00H       ; 0084 _ tion....

?_020:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 6DH, 6FH, 76H, 65H       ; 008C _  [--move
        db 73H, 3DH, 69H, 5DH, 20H, 20H, 20H, 20H       ; 0094 _ s=i]    
        db 20H, 20H, 20H, 20H, 4DH, 6FH, 76H, 65H       ; 009C _     Move
        db 73H, 20H, 28H, 64H, 65H, 66H, 61H, 75H       ; 00A4 _ s (defau
        db 6CH, 74H, 20H, 3DH, 20H, 32H, 29H, 20H       ; 00AC _ lt = 2) 
        db 31H, 2DH, 39H, 20H, 61H, 72H, 65H, 20H       ; 00B4 _ 1-9 are 
        db 76H, 61H, 6CH, 69H, 64H, 0AH, 00H, 00H       ; 00BC _ valid...

?_021:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 73H, 6FH, 6CH, 73H       ; 00C4 _  [--sols
        db 3DH, 69H, 5DH, 20H, 20H, 20H, 20H, 20H       ; 00CC _ =i]     
        db 20H, 20H, 20H, 20H, 53H, 6FH, 6CH, 75H       ; 00D4 _     Solu
        db 74H, 69H, 6FH, 6EH, 73H, 20H, 28H, 64H       ; 00DC _ tions (d
        db 65H, 66H, 61H, 75H, 6CH, 74H, 20H, 3DH       ; 00E4 _ efault =
        db 20H, 31H, 29H, 20H, 31H, 2DH, 39H, 20H       ; 00EC _  1) 1-9 
        db 61H, 72H, 65H, 20H, 76H, 61H, 6CH, 69H       ; 00F4 _ are vali
        db 64H, 0AH, 00H, 00H                           ; 00FC _ d...

?_022:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 63H, 61H, 73H, 74H       ; 0100 _  [--cast
        db 6CH, 69H, 6EH, 67H, 3DH, 73H, 5DH, 20H       ; 0108 _ ling=s] 
        db 20H, 20H, 20H, 20H, 43H, 61H, 73H, 74H       ; 0110 _     Cast
        db 6CH, 69H, 6EH, 67H, 20H, 72H, 69H, 67H       ; 0118 _ ling rig
        db 68H, 74H, 73H, 20H, 2DH, 20H, 65H, 67H       ; 0120 _ hts - eg
        db 2EH, 20H, 4BH, 51H, 6BH, 71H, 20H, 66H       ; 0128 _ . KQkq f
        db 6FH, 72H, 20H, 66H, 75H, 6CH, 6CH, 20H       ; 0130 _ or full 
        db 63H, 61H, 73H, 74H, 6CH, 69H, 6EH, 67H       ; 0138 _ castling
        db 0AH, 00H, 00H, 00H                           ; 0140 _ ....

?_023:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 65H, 70H, 3DH, 73H       ; 0144 _  [--ep=s
        db 5DH, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 014C _ ]       
        db 20H, 20H, 20H, 20H, 53H, 71H, 75H, 61H       ; 0154 _     Squa
        db 72H, 65H, 20H, 6FH, 66H, 20H, 61H, 20H       ; 015C _ re of a 
        db 70H, 61H, 77H, 6EH, 20H, 74H, 68H, 61H       ; 0164 _ pawn tha
        db 74H, 20H, 63H, 61H, 6EH, 20H, 62H, 65H       ; 016C _ t can be
        db 20H, 74H, 61H, 6BH, 65H, 6EH, 20H, 65H       ; 0174 _  taken e
        db 70H, 0AH, 00H, 00H                           ; 017C _ p...

?_024:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 72H, 65H, 66H, 75H       ; 0180 _  [--refu
        db 74H, 73H, 3DH, 69H, 5DH, 20H, 20H, 20H       ; 0188 _ ts=i]   
        db 20H, 20H, 20H, 20H, 4EH, 75H, 6DH, 62H       ; 0190 _     Numb
        db 65H, 72H, 20H, 6FH, 66H, 20H, 72H, 65H       ; 0198 _ er of re
        db 66H, 75H, 74H, 61H, 74H, 69H, 6FH, 6EH       ; 01A0 _ futation
        db 73H, 20H, 66H, 6FH, 72H, 20H, 74H, 72H       ; 01A8 _ s for tr
        db 69H, 65H, 73H, 20H, 28H, 64H, 65H, 66H       ; 01B0 _ ies (def
        db 61H, 75H, 6CH, 74H, 20H, 3DH, 20H, 30H       ; 01B8 _ ault = 0
        db 29H, 20H, 31H, 2DH, 39H, 20H, 61H, 72H       ; 01C0 _ ) 1-9 ar
        db 65H, 20H, 76H, 61H, 6CH, 69H, 64H, 0AH       ; 01C8 _ e valid.
        db 00H, 00H, 00H, 00H                           ; 01D0 _ ....

?_025:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 74H, 68H, 72H, 65H       ; 01D4 _  [--thre
        db 61H, 74H, 73H, 3DH, 73H, 5DH, 20H, 20H       ; 01DC _ ats=s]  
        db 20H, 20H, 20H, 20H, 43H, 61H, 6CH, 63H       ; 01E4 _     Calc
        db 75H, 6CH, 61H, 74H, 65H, 20H, 74H, 68H       ; 01EC _ ulate th
        db 72H, 65H, 61H, 74H, 73H, 20H, 2DH, 20H       ; 01F4 _ reats - 
        db 4EH, 4FH, 4EH, 45H, 2CH, 20H, 53H, 48H       ; 01FC _ NONE, SH
        db 4FH, 52H, 54H, 45H, 53H, 54H, 20H, 28H       ; 0204 _ ORTEST (
        db 74H, 68H, 65H, 20H, 64H, 65H, 66H, 61H       ; 020C _ the defa
        db 75H, 6CH, 74H, 29H, 20H, 6FH, 72H, 20H       ; 0214 _ ult) or 
        db 41H, 4CH, 4CH, 0AH, 00H, 00H, 00H, 00H       ; 021C _ ALL.....

?_026:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 68H, 61H, 73H, 68H       ; 0224 _  [--hash
        db 5DH, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 022C _ ]       
        db 20H, 20H, 20H, 20H, 55H, 73H, 65H, 20H       ; 0234 _     Use 
        db 61H, 20H, 74H, 72H, 61H, 6EH, 73H, 70H       ; 023C _ a transp
        db 6FH, 73H, 69H, 74H, 69H, 6FH, 6EH, 20H       ; 0244 _ osition 
        db 68H, 61H, 73H, 68H, 20H, 74H, 61H, 62H       ; 024C _ hash tab
        db 6CH, 65H, 0AH, 00H                           ; 0254 _ le..

?_027:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 68H, 65H, 6CH, 70H       ; 0258 _  [--help
        db 5DH, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 0260 _ ]       
        db 20H, 20H, 20H, 20H, 44H, 69H, 73H, 70H       ; 0268 _     Disp
        db 6CH, 61H, 79H, 20H, 74H, 68H, 69H, 73H       ; 0270 _ lay this
        db 20H, 68H, 65H, 6CH, 70H, 20H, 6DH, 65H       ; 0278 _  help me
        db 73H, 73H, 61H, 67H, 65H, 0AH, 00H, 00H       ; 0280 _ ssage...

?_028:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 73H, 65H, 74H, 5DH       ; 0288 _  [--set]
        db 20H, 20H, 20H, 20H, 20H, 20H, 20H, 20H       ; 0290 _         
        db 20H, 20H, 20H, 20H, 43H, 61H, 6CH, 63H       ; 0298 _     Calc
        db 75H, 6CH, 61H, 74H, 65H, 20H, 73H, 65H       ; 02A0 _ ulate se
        db 74H, 20H, 70H, 6CH, 61H, 79H, 0AH, 00H       ; 02A8 _ t play..

?_029:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 74H, 72H, 69H, 65H       ; 02B0 _  [--trie
        db 73H, 5DH, 20H, 20H, 20H, 20H, 20H, 20H       ; 02B8 _ s]      
        db 20H, 20H, 20H, 20H, 43H, 61H, 6CH, 63H       ; 02C0 _     Calc
        db 75H, 6CH, 61H, 74H, 65H, 20H, 74H, 72H       ; 02C8 _ ulate tr
        db 69H, 65H, 73H, 0AH, 00H, 00H, 00H, 00H       ; 02D0 _ ies.....

?_030:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 74H, 72H, 69H, 76H       ; 02D8 _  [--triv
        db 69H, 61H, 6CH, 74H, 72H, 69H, 65H, 73H       ; 02E0 _ ialtries
        db 5DH, 20H, 20H, 20H, 49H, 6EH, 63H, 6CH       ; 02E8 _ ]   Incl
        db 75H, 64H, 65H, 20H, 74H, 72H, 69H, 76H       ; 02F0 _ ude triv
        db 69H, 61H, 6CH, 20H, 74H, 72H, 69H, 65H       ; 02F8 _ ial trie
        db 73H, 0AH, 00H, 00H                           ; 0300 _ s...

?_031:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 61H, 63H, 74H, 75H       ; 0304 _  [--actu
        db 61H, 6CH, 5DH, 20H, 20H, 20H, 20H, 20H       ; 030C _ al]     
        db 20H, 20H, 20H, 20H, 43H, 61H, 6CH, 63H       ; 0314 _     Calc
        db 75H, 6CH, 61H, 74H, 65H, 20H, 61H, 63H       ; 031C _ ulate ac
        db 74H, 75H, 61H, 6CH, 20H, 70H, 6CH, 61H       ; 0324 _ tual pla
        db 79H, 0AH, 00H, 00H                           ; 032C _ y...

?_032:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 73H, 68H, 6FH, 72H       ; 0330 _  [--shor
        db 74H, 76H, 61H, 72H, 73H, 5DH, 20H, 20H       ; 0338 _ tvars]  
        db 20H, 20H, 20H, 20H, 49H, 6EH, 63H, 6CH       ; 0340 _     Incl
        db 75H, 64H, 65H, 20H, 73H, 68H, 6FH, 72H       ; 0348 _ ude shor
        db 74H, 20H, 76H, 61H, 72H, 69H, 61H, 74H       ; 0350 _ t variat
        db 69H, 6FH, 6EH, 73H, 0AH, 00H, 00H, 00H       ; 0358 _ ions....

?_033:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 66H, 6CH, 65H, 63H       ; 0360 _  [--flec
        db 6BH, 5DH, 20H, 20H, 20H, 20H, 20H, 20H       ; 0368 _ k]      
        db 20H, 20H, 20H, 20H, 52H, 65H, 74H, 61H       ; 0370 _     Reta
        db 69H, 6EH, 20H, 76H, 61H, 72H, 69H, 61H       ; 0378 _ in varia
        db 74H, 69H, 6FH, 6EH, 73H, 20H, 74H, 68H       ; 0380 _ tions th
        db 61H, 74H, 20H, 61H, 6CH, 6CH, 6FH, 77H       ; 0388 _ at allow
        db 20H, 73H, 6FH, 6DH, 65H, 20H, 28H, 62H       ; 0390 _  some (b
        db 75H, 74H, 20H, 6EH, 6FH, 74H, 20H, 61H       ; 0398 _ ut not a
        db 6CH, 6CH, 29H, 20H, 6FH, 66H, 20H, 74H       ; 03A0 _ ll) of t
        db 68H, 65H, 20H, 74H, 68H, 72H, 65H, 61H       ; 03A8 _ he threa
        db 74H, 73H, 0AH, 00H                           ; 03B0 _ ts..

?_034:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 6DH, 65H, 73H, 6FH       ; 03B4 _  [--meso
        db 6EH, 5DH, 20H, 20H, 20H, 20H, 20H, 20H       ; 03BC _ n]      
        db 20H, 20H, 20H, 20H, 52H, 75H, 6EH, 6EH       ; 03C4 _     Runn
        db 69H, 6EH, 67H, 20H, 66H, 72H, 6FH, 6DH       ; 03CC _ ing from
        db 20H, 4DH, 65H, 73H, 6FH, 6EH, 20H, 64H       ; 03D4 _  Meson d
        db 61H, 74H, 61H, 62H, 61H, 73H, 65H, 2CH       ; 03DC _ atabase,
        db 20H, 64H, 65H, 66H, 61H, 75H, 6CH, 74H       ; 03E4 _  default
        db 20H, 69H, 73H, 20H, 66H, 61H, 6CH, 73H       ; 03EC _  is fals
        db 65H, 0AH, 00H, 00H                           ; 03F4 _ e...

?_035:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 63H, 6CH, 61H, 73H       ; 03F8 _  [--clas
        db 73H, 69H, 66H, 79H, 5DH, 20H, 20H, 20H       ; 0400 _ sify]   
        db 20H, 20H, 20H, 20H, 43H, 6CH, 61H, 73H       ; 0408 _     Clas
        db 73H, 69H, 66H, 79H, 20H, 70H, 72H, 6FH       ; 0410 _ sify pro
        db 62H, 6CH, 65H, 6DH, 0AH, 00H, 00H, 00H       ; 0418 _ blem....

?_036:                                                  ; byte
        db 20H, 5BH, 2DH, 2DH, 76H, 65H, 72H, 73H       ; 0420 _  [--vers
        db 69H, 6FH, 6EH, 5DH, 20H, 20H, 20H, 20H       ; 0428 _ ion]    
        db 20H, 20H, 20H, 20H, 44H, 69H, 73H, 70H       ; 0430 _     Disp
        db 6CH, 61H, 79H, 20H, 70H, 72H, 6FH, 67H       ; 0438 _ lay prog
        db 72H, 61H, 6DH, 20H, 76H, 65H, 72H, 73H       ; 0440 _ ram vers
        db 69H, 6FH, 6EH, 0AH, 00H                      ; 0448 _ ion..

?_037:                                                  ; byte
        db 00H, 6BH, 69H, 6EH, 67H, 73H, 00H, 67H       ; 044D _ .kings.g
        db 62H, 72H, 00H, 70H, 6FH, 73H, 00H, 6DH       ; 0455 _ br.pos.m
        db 6FH, 76H, 65H, 73H, 00H, 73H, 6FH, 6CH       ; 045D _ oves.sol
        db 73H, 00H, 63H, 61H, 73H, 74H, 6CH, 69H       ; 0465 _ s.castli
        db 6EH, 67H, 00H, 65H, 70H, 00H, 72H, 65H       ; 046D _ ng.ep.re
        db 66H, 75H, 74H, 73H, 00H, 74H, 68H, 72H       ; 0475 _ futs.thr
        db 65H, 61H, 74H, 73H, 00H, 68H, 61H, 73H       ; 047D _ eats.has
        db 68H, 00H, 68H, 65H, 6CH, 70H, 00H, 73H       ; 0485 _ h.help.s
        db 65H, 74H, 00H, 74H, 72H, 69H, 65H, 73H       ; 048D _ et.tries
        db 00H, 74H, 72H, 69H, 76H, 69H, 61H, 6CH       ; 0495 _ .trivial
        db 74H, 72H, 69H, 65H, 73H, 00H, 61H, 63H       ; 049D _ tries.ac
        db 74H, 75H, 61H, 6CH, 00H, 73H, 68H, 6FH       ; 04A5 _ tual.sho
        db 72H, 74H, 76H, 61H, 72H, 73H, 00H, 66H       ; 04AD _ rtvars.f
        db 6CH, 65H, 63H, 6BH, 00H, 6DH, 65H, 73H       ; 04B5 _ leck.mes
        db 6FH, 6EH, 00H, 63H, 6CH, 61H, 73H, 73H       ; 04BD _ on.class
        db 69H, 66H, 79H, 00H, 76H, 65H, 72H, 73H       ; 04C5 _ ify.vers
        db 69H, 6FH, 6EH, 00H, 00H, 00H, 00H, 00H       ; 04CD _ ion.....
        db 00H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 04D5 _ ........
        db 00H, 00H, 00H                                ; 04DD _ ...

?_038:                                                  ; byte
        dd ?_016+44EH                                   ; 04E0 _ 0000044E (d)
        dd 00000000H, 00000000H                         ; 04E4 _ 0 0 
        dd 00000061H                                    ; 04EC _ 97 
        dd ?_016+454H                                   ; 04F0 _ 00000454 (d)
        dd 00000001H, 00000000H                         ; 04F4 _ 1 0 
        dd 00000062H                                    ; 04FC _ 98 
        dd ?_016+458H                                   ; 0500 _ 00000458 (d)
        dd 00000001H, 00000000H                         ; 0504 _ 1 0 
        dd 00000063H                                    ; 050C _ 99 
        dd ?_016+45CH                                   ; 0510 _ 0000045C (d)
        dd 00000001H, 00000000H                         ; 0514 _ 1 0 
        dd 00000064H                                    ; 051C _ 100 
        dd ?_016+462H                                   ; 0520 _ 00000462 (d)
        dd 00000001H, 00000000H                         ; 0524 _ 1 0 
        dd 00000065H                                    ; 052C _ 101 
        dd ?_016+467H                                   ; 0530 _ 00000467 (d)
        dd 00000001H, 00000000H                         ; 0534 _ 1 0 
        dd 00000066H                                    ; 053C _ 102 
        dd ?_016+470H                                   ; 0540 _ 00000470 (d)
        dd 00000001H, 00000000H                         ; 0544 _ 1 0 
        dd 00000067H                                    ; 054C _ 103 
        dd ?_016+473H                                   ; 0550 _ 00000473 (d)
        dd 00000001H, 00000000H                         ; 0554 _ 1 0 
        dd 00000068H                                    ; 055C _ 104 
        dd ?_016+47AH                                   ; 0560 _ 0000047A (d)
        dd 00000001H, 00000000H                         ; 0564 _ 1 0 
        dd 00000069H                                    ; 056C _ 105 
        dd ?_016+482H                                   ; 0570 _ 00000482 (d)
        dd 00000000H, 00000000H                         ; 0574 _ 0 0 
        dd 0000006AH                                    ; 057C _ 106 
        dd ?_016+487H                                   ; 0580 _ 00000487 (d)
        dd 00000000H, 00000000H                         ; 0584 _ 0 0 
        dd 0000006BH                                    ; 058C _ 107 
        dd ?_016+48CH                                   ; 0590 _ 0000048C (d)
        dd 00000000H, 00000000H                         ; 0594 _ 0 0 
        dd 0000006CH                                    ; 059C _ 108 
        dd ?_016+490H                                   ; 05A0 _ 00000490 (d)
        dd 00000000H, 00000000H                         ; 05A4 _ 0 0 
        dd 0000006DH                                    ; 05AC _ 109 
        dd ?_016+496H                                   ; 05B0 _ 00000496 (d)
        dd 00000000H, 00000000H                         ; 05B4 _ 0 0 
        dd 0000006EH                                    ; 05BC _ 110 
        dd ?_016+4A3H                                   ; 05C0 _ 000004A3 (d)
        dd 00000000H, 00000000H                         ; 05C4 _ 0 0 
        dd 0000006FH                                    ; 05CC _ 111 
        dd ?_016+4AAH                                   ; 05D0 _ 000004AA (d)
        dd 00000000H, 00000000H                         ; 05D4 _ 0 0 
        dd 00000070H                                    ; 05DC _ 112 
        dd ?_016+4B4H                                   ; 05E0 _ 000004B4 (d)
        dd 00000000H, 00000000H                         ; 05E4 _ 0 0 
        dd 00000071H                                    ; 05EC _ 113 
        dd ?_016+4BAH                                   ; 05F0 _ 000004BA (d)
        dd 00000000H, 00000000H                         ; 05F4 _ 0 0 
        dd 00000072H                                    ; 05FC _ 114 
        dd ?_016+4C0H                                   ; 0600 _ 000004C0 (d)
        dd 00000000H, 00000000H                         ; 0604 _ 0 0 
        dd 00000073H                                    ; 060C _ 115 
        dd ?_016+4C9H                                   ; 0610 _ 000004C9 (d)
        dd 00000000H, 00000000H                         ; 0614 _ 0 0 
        dd 00000074H, 00000000H                         ; 061C _ 116 0 
        dd 00000000H, 00000000H                         ; 0624 _ 0 0 
        dd 00000000H                                    ; 062C _ 0 

?_039:                                                  ; switch/case jump table
        dd ?_014                                        ; 0630 _ 000003C9 (d)
        dd ?_014                                        ; 0634 _ 000003C9 (d)
        dd ?_014                                        ; 0638 _ 000003C9 (d)
        dd ?_014                                        ; 063C _ 000003C9 (d)
        dd ?_014                                        ; 0640 _ 000003C9 (d)
        dd ?_014                                        ; 0644 _ 000003C9 (d)
        dd ?_014                                        ; 0648 _ 000003C9 (d)
        dd ?_014                                        ; 064C _ 000003C9 (d)
        dd ?_014                                        ; 0650 _ 000003C9 (d)
        dd ?_002                                        ; 0654 _ 00000363 (d)
        dd ?_003                                        ; 0658 _ 0000036C (d)
        dd ?_004                                        ; 065C _ 00000375 (d)
        dd ?_005                                        ; 0660 _ 0000037E (d)
        dd ?_006                                        ; 0664 _ 00000387 (d)
        dd ?_007                                        ; 0668 _ 00000390 (d)
        dd ?_008                                        ; 066C _ 00000399 (d)
        dd ?_009                                        ; 0670 _ 000003A2 (d)
        dd ?_010                                        ; 0674 _ 000003AB (d)
        dd ?_011                                        ; 0678 _ 000003B4 (d)
        dd ?_012                                        ; 067C _ 000003BD (d)


SECTION .eh_frame align=4 noexecute                     ; section number 5, const

        db 14H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0000 _ ........
        db 01H, 7AH, 52H, 00H, 01H, 7CH, 08H, 01H       ; 0008 _ .zR..|..
        db 1BH, 0CH, 04H, 04H, 88H, 01H, 00H, 00H       ; 0010 _ ........
        db 1CH, 00H, 00H, 00H, 1CH, 00H, 00H, 00H       ; 0018 _ ........
        dd do_usage-$-20H                               ; 0020 _ 00000000 (rel)
        dd 00000312H, 080E4100H                         ; 0024 _ 786 135151872 
        dd 0D420285H, 030E0305H                         ; 002C _ 222429829 51249925 
        dd 04040CC5H, 00000028H                         ; 0034 _ 67374277 40 
        dd 0000003CH                                    ; 003C _ 60 
        dd do_usage-$+2D2H                              ; 0040 _ 00000312 (rel)
        dd 0000010AH, 080E4100H                         ; 0044 _ 266 135151872 
        dd 0D420285H, 03874905H                         ; 004C _ 222429829 59197701 
        dd 05830486H, 41C3FA02H                         ; 0054 _ 92472454 1103362562 
        dd 41C741C6H, 04040CC5H                         ; 005C _ 1103577542 67374277 


; Error: Relocation number 1 has a non-existing source address. Section: 0 Offset: 00000006H
; Error: Relocation number 2 has a non-existing source address. Section: 0 Offset: 00000006H
; Error: Relocation number 3 has a non-existing source address. Section: 0 Offset: 0000000CH
; Error: Relocation number 4 has a non-existing source address. Section: 0 Offset: 00000010H
; Error: Relocation number 5 has a non-existing source address. Section: 0 Offset: 00000011H
; Error: Relocation number 6 has a non-existing source address. Section: 0 Offset: 00000015H
; Error: Relocation number 7 has a non-existing source address. Section: 0 Offset: 00000019H
; Error: Relocation number 8 has a non-existing source address. Section: 0 Offset: 00000021H
; Error: Relocation number 9 has a non-existing source address. Section: 0 Offset: 00000026H
; Error: Relocation number 10 has a non-existing source address. Section: 0 Offset: 00000033H
; Error: Relocation number 11 has a non-existing source address. Section: 0 Offset: 0000003AH
; Error: Relocation number 12 has a non-existing source address. Section: 0 Offset: 00000041H
; Error: Relocation number 13 has a non-existing source address. Section: 0 Offset: 00000048H
; Error: Relocation number 14 has a non-existing source address. Section: 0 Offset: 0000004FH
; Error: Relocation number 15 has a non-existing source address. Section: 0 Offset: 00000056H
; Error: Relocation number 16 has a non-existing source address. Section: 0 Offset: 00000064H
; Error: Relocation number 17 has a non-existing source address. Section: 0 Offset: 0000006BH
; Error: Relocation number 18 has a non-existing source address. Section: 0 Offset: 00000070H
; Error: Relocation number 19 has a non-existing source address. Section: 0 Offset: 0000007BH
; Error: Relocation number 20 has a non-existing source address. Section: 0 Offset: 00000088H
; Error: Relocation number 21 has a non-existing source address. Section: 0 Offset: 0000008DH
; Error: Relocation number 22 has a non-existing source address. Section: 0 Offset: 0000009AH
; Error: Relocation number 23 has a non-existing source address. Section: 0 Offset: 000000A9H
; Error: Relocation number 24 has a non-existing source address. Section: 0 Offset: 000000AEH
; Error: Relocation number 25 has a non-existing source address. Section: 0 Offset: 000000B9H
; Error: Relocation number 26 has a non-existing source address. Section: 0 Offset: 000000BAH
; Error: Relocation number 27 has a non-existing source address. Section: 0 Offset: 000000C6H
; Error: Relocation number 28 has a non-existing source address. Section: 0 Offset: 000000D2H
; Error: Relocation number 29 has a non-existing source address. Section: 0 Offset: 000000DEH
; Error: Relocation number 30 has a non-existing source address. Section: 0 Offset: 000000EAH
; Error: Relocation number 31 has a non-existing source address. Section: 0 Offset: 000000F6H
; Error: Relocation number 32 has a non-existing source address. Section: 0 Offset: 00000102H
; Error: Relocation number 33 has a non-existing source address. Section: 0 Offset: 0000010FH
; Error: Relocation number 34 has a non-existing source address. Section: 0 Offset: 0000011CH
; Error: Relocation number 35 has a non-existing source address. Section: 0 Offset: 00000129H
; Error: Relocation number 36 has a non-existing source address. Section: 0 Offset: 00000136H
; Error: Relocation number 37 has a non-existing source address. Section: 0 Offset: 00000143H
; Error: Relocation number 38 has a non-existing source address. Section: 0 Offset: 00000150H
; Error: Relocation number 39 has a non-existing source address. Section: 0 Offset: 0000015DH
; Error: Relocation number 40 has a non-existing source address. Section: 0 Offset: 0000016AH
; Error: Relocation number 41 has a non-existing source address. Section: 0 Offset: 00000177H
; Error: Relocation number 42 has a non-existing source address. Section: 0 Offset: 00000184H
; Error: Relocation number 43 has a non-existing source address. Section: 0 Offset: 00000191H
; Error: Relocation number 44 has a non-existing source address. Section: 0 Offset: 0000019EH
; Error: Relocation number 45 has a non-existing source address. Section: 0 Offset: 000001ABH
; Error: Relocation number 46 has a non-existing source address. Section: 0 Offset: 000001B8H
; Error: Relocation number 47 has a non-existing source address. Section: 0 Offset: 000001C5H
; Error: Relocation number 48 has a non-existing source address. Section: 0 Offset: 000001D2H
; Error: Relocation number 49 has a non-existing source address. Section: 0 Offset: 000001DFH
; Error: Relocation number 50 has a non-existing source address. Section: 0 Offset: 000001ECH
; Error: Relocation number 51 has a non-existing source address. Section: 0 Offset: 000001F9H
; Error: Relocation number 52 has a non-existing source address. Section: 0 Offset: 00000206H
; Error: Relocation number 53 has a non-existing source address. Section: 0 Offset: 00000213H
; Error: Relocation number 54 has a non-existing source address. Section: 0 Offset: 00000220H
; Error: Relocation number 55 has a non-existing source address. Section: 0 Offset: 0000022EH
; Error: Relocation number 56 has a non-existing source address. Section: 0 Offset: 00000235H
; Error: Relocation number 57 has a non-existing source address. Section: 0 Offset: 00000241H
; Error: Relocation number 58 has a non-existing source address. Section: 0 Offset: 0000024DH
; Error: Relocation number 59 has a non-existing source address. Section: 0 Offset: 00000259H
; Error: Relocation number 60 has a non-existing source address. Section: 0 Offset: 000002A3H
; Error: Relocation number 61 has a non-existing source address. Section: 0 Offset: 000002AFH
; Error: Relocation number 62 has a non-existing source address. Section: 0 Offset: 000002BBH
; Error: Relocation number 63 has a non-existing source address. Section: 0 Offset: 000002C7H
; Error: Relocation number 64 has a non-existing source address. Section: 0 Offset: 000002E6H
; Error: Relocation number 65 has a non-existing source address. Section: 0 Offset: 000002ECH
; Error: Relocation number 66 has a non-existing source address. Section: 0 Offset: 000002F7H
; Error: Relocation number 67 has a non-existing source address. Section: 0 Offset: 00000301H
; Error: Relocation number 68 has a non-existing source address. Section: 0 Offset: 00000310H
; Error: Relocation number 69 has a non-existing source address. Section: 0 Offset: 0000031EH
; Error: Relocation number 70 has a non-existing source address. Section: 0 Offset: 0000033AH
; Error: Relocation number 71 has a non-existing source address. Section: 0 Offset: 00000358H
; Error: Relocation number 72 has a non-existing source address. Section: 0 Offset: 0000037EH
; Error: Relocation number 73 has a non-existing source address. Section: 0 Offset: 00000389H
; Error: Relocation number 74 has a non-existing source address. Section: 0 Offset: 00000396H
; Error: Relocation number 75 has a non-existing source address. Section: 0 Offset: 0000039BH
; Error: Relocation number 76 has a non-existing source address. Section: 0 Offset: 000003A6H
; Error: Relocation number 77 has a non-existing source address. Section: 0 Offset: 000003B1H
; Error: Relocation number 78 has a non-existing source address. Section: 0 Offset: 000003BCH
; Error: Relocation number 79 has a non-existing source address. Section: 0 Offset: 000003C7H
; Error: Relocation number 80 has a non-existing source address. Section: 0 Offset: 000003D2H
; Error: Relocation number 81 has a non-existing source address. Section: 0 Offset: 000003DDH
; Error: Relocation number 82 has a non-existing source address. Section: 0 Offset: 000003E8H
; Error: Relocation number 83 has a non-existing source address. Section: 0 Offset: 000003F3H
; Error: Relocation number 84 has a non-existing source address. Section: 0 Offset: 000003FEH

