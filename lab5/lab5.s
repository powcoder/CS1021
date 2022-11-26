https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
;
; CS1021 2018/2019	Lab 5
;
; RAM @ 0x4000000 sz = 0x10000 (64K)
;

;
; hardware registers
;

PINSEL0	EQU	0xE002C000
	
U0RBR	EQU	0xE000C000
U0THR	EQU	0xE000C000
U0LCR	EQU	0xE000C00C
U0LSR	EQU	0xE000C014
	
	
	AREA	RESET, CODE, READONLY
	ENTRY	
	
;	
; hardware initialisation
;
	LDR	R13, =0x40010000	; initialse SP
	LDR	R0, =PINSEL0		; enable UART0 TxD and RxD signals
	MOV	R1, #0x50		;
	STRB	R1, [R0]		;
	LDR	R0, =U0LCR		; R0 - > U0LCR (line control register)
	LDR	R1, =0x02		; 7 data bits + parity
	STRB	R1, [R0]		;

;
; output "ECHO ECho echo ..." to console
; echo typed characters (type CTRL j for a line feed)
;
; replace this with your code
;
	LDR	R0, =STR0		; R0 -> "ECHO ECho echo ..."
	BL	PUTS			; put string
L	BL	GET			; get character
	BL	PUT			; put character
	B	L			; forever
	
	
STR0	DCB	"ECHO ECho echo...", 0x0a, 0, 0

;
; subroutines
;	
; GET
;
; leaf function which returns ASCII character typed in UART #1 window in R0
;
GET	LDR	R1, =U0LSR		; R1 -> U0LSR (Line Status Register)
GET0	LDR	R0, [R1]		; wait until
	ANDS	R0, #0x01		; receiver data
	BEQ	GET0			; ready
	LDR	R1, =U0RBR		; R1 -> U0RBR (Receiver Buffer Register)
	LDRB	R0, [R1]		; get received data
	BX	LR			; return

;	
; PUT
;
; leaf function which sends ASCII character in R0 to UART #1 window
;
PUT	LDR	R1, =U0LSR		; R1 -> U0LSR (Line Status Register)
	LDRB	R1, [R1]		; wait until transmit
	ANDS	R1, R1, #0x20		; holding register
	BEQ	PUT			; empty
	LDR	R1, =U0THR		; R1 -> U0THR
	STRB	R0, [R1]		; output charcter
PUT0	LDR	R1, =U0LSR		; R1 -> U0LSR
	LDRB	R1, [R1]		; wait until 
	ANDS	R1, R1, #0x40		; transmitter
	BEQ	PUT0			; empty (data flushed)
	BX	LR			; return

;	
; PUTS
;
; sends NUL terminated ASCII string (address in R0) to UART #1 window
;
PUTS	PUSH	{R4, LR} 		; push R4 and LR
	MOV	R4, R0			; copy R0
PUTS0	LDRB	R0, [R4], #1		; get character + increment R4
	CMP	R0, #0			; 0?
	BEQ	PUTS1			; return
	BL	PUT			; put character
	B	PUTS0			; next character
PUTS1	POP	{R4, PC} 		; pop R4 and PC
	
	END