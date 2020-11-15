;  adump
;     adump.inc
;
;  This is a coding exercise. It dumps the contents of any file in Hex and ASCII
;
;  (c) 2019, Brian Stephenson
;  brian@bstephen.me.uk
;
%define 		ADUMP_NAME			'adump'
%define 		ADUMP_VERSION		'1.0'
%define 		ADUMP_AUTHOR		'Brian Stephenson'
%define 		ADUMP_YEAR			'2019'
%define 		ADUMP_EMAIL			'brian@bstephen.me.uk'
%define		CR						10
%define 		EXIT_SUCCESS		0
%define 		EXIT_FAILURE		1
%define		BUFF_LEN				16

%macro		MUST_SAVE       0
				push		EBX
				push		ESI
				push		EDI
				push		EBP
%endmacro

%macro      MUST_RESTORE    0
				pop		EBP
				pop		EDI
				pop		ESI	
				pop		EBX
%endmacro
