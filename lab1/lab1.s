https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
;
; CS1021 2018/2019	Lab 1
; 

	AREA	RESET, CODE, READONLY
	ENTRY

;
; start of code
;
	LDR	R1, =5   	; x = 5
	LDR	R2, =6		; y = 6

;
; compute x*x + y + 4 (35 or 0x23)
;
	MUL	R0, R1, R1	; R0 = x*x
	ADD	R0, R0, R2	; R0 = x*x + y
	ADD	R0, R0, #4	; R0 = x*x + y + 4
	
;
; add your code here
;

L	B	L		; infinite loop to end programme

        END
