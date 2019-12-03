
; Project Name : Implementation of Error detection and correction Algorithm in ARM CORTEX-M4

; Submitted by : Ajay Gummuluri , Anmol Jain , Modupalli Rammohan , M.V.Sai Krishna

; Description: Generates a 12-bit Hamming Code in R0 from an 8-bit value in R1
;              and introduce an error by flipping a bit in R0 and then correcting it.
;	

	THUMB
	 AREA     HammingCode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main    FUNCTION

	
	LDR	R1, =0xAB          ; Input data is stored in R1

	; Expanding the 8-bit value to 12-bits by inserting
	; zeros in the positions for the four check bits bit 1, bit 2, bit 4
	; and bit 8.
	
	AND	R2, R1, #0x1		; Clear all bits apart from data bit at LSB
	MOV	R0, R2, LSL #2		; Align data bit d0 at position 3
	
	AND	R2, R1, #0xE		; Clear all bits apart from d1, d2, & d3
	ORR	R0, R0, R2, LSL #3	; Align data bits d1, d2 & d3 and combine with d0
	
	AND	R2, R1, #0xF0		; Clear all bits apart from d3-d7
	ORR	R0, R0, R2, LSL #4	; Align data bits d4-d7 and combine with d0-d3
	
	; We now have a 12-bit value in R0 with the check bits having
	; zeros in their positions
	
	; Check bits Generation
	
	
	
	; Generating check bit c0
	
	EOR	R2, R0, R0, LSR #2	; Generate c0 parity bit using parity tree
	EOR	R2, R2, R2, LSR #4	 
	EOR	R2, R2, R2, LSR #8	 
	
	AND	R2, R2, #0x1		; Clear all but check bit c0
	ORR	R0, R0, R2		; Combine check bit c0 with result
	
	; Generating check bit c1
	
	EOR	R2, R0, R0, LSR #1	; Generate c1 parity bit using parity tree
	EOR	R2, R2, R2, LSR #4	 
	EOR	R2, R2, R2, LSR #8	
	
	AND	R2, R2, #0x2		; Clear all but check bit c1
	ORR	R0, R0, R2		; Combine check bit c1 with result
	
	; Generating check bit c2
	
	EOR	R2, R0, R0, LSR #1	; Generate c2 parity bit using parity tree
	EOR	R2, R2, R2, LSR #2	
	EOR	R2, R2, R2, LSR #8	
	
	AND	R2, R2, #0x8		; Clear all but check bit c2
	ORR	R0, R0, R2		; Combine check bit c2 with result	
	
	; Generating check bit c3
	
	EOR	R2, R0, R0, LSR #1	; Generate c3 parity bit using parity tree
	EOR	R2, R2, R2, LSR #2	
	EOR	R2, R2, R2, LSR #4	
	
	AND	R2, R2, #0x80		; Clear all but check bit c3
	ORR	R0, R0, R2		; Combine check bit c3 with result
	
	; We now have a 12-bit value with Hamming code check bits
	
	; Creating an error by flipping a bit.
	
	EOR	R0, R0, #0x100		; Flip bit 8 to test
	
	
	
	
	
    ;Error detection

	;Clear bits c0, c1, c3, c7
	LDR R3, =0XFFFFFF74
	AND R3, R0, R3



	; Generate check bit c0
	
	EOR	R2, R3, R3, LSR #2	; Generate c0 parity bit using parity tree
	EOR	R2, R2, R2, LSR #4	
	EOR	R2, R2, R2, LSR #8	
	
	AND	R2, R2, #0x1		; Clear all but check bit c0
	ORR	R3, R3, R2		    ; Combine check bit c0 with result
	
	; Generate check bit c1
	
	EOR	R2, R3, R3, LSR #1	; Generate c1 parity bit using parity tree
	EOR	R2, R2, R2, LSR #4	
	EOR	R2, R2, R2, LSR #8	
	
	AND	R2, R2, #0x2		; Clear all but check bit c1
	ORR	R3, R3, R2		; Combine check bit c1 with result
	
	; Generate check bit c2
	
	EOR	R2, R3, R3, LSR #1	; Generate c2 parity bit using parity tree
	EOR	R2, R2, R2, LSR #2	
	EOR	R2, R2, R2, LSR #8	
	
	AND	R2, R2, #0x8		; Clear all but check bit c2
	ORR	R3, R3, R2		; Combine check bit c2 with result	
	
	; Generate check bit c3
	
	EOR	R2, R3, R3, LSR #1	; Generate c3 parity bit using parity tree
	EOR	R2, R2, R2, LSR #2	; ... second iteration ...
	EOR	R2, R2, R2, LSR #4	; ... final iteration
	
	AND	R2, R2, #0x80		; Clear all but check bit c3
	ORR	R3, R3, R2		; Combine check bit c3 with result


	
	
	EOR R1, R0, R3   ; ;Compare the original value in R0 and the new value in R3.


	;Isolate the results of the EOR operation to result in a 4-bit calculation

	;Clearing all bits apart from c7 and shifting bit 4 positions right
	LDR R4, =0X80
	AND R4, R4, R1
	MOV R4, R4, LSR #4

	;Clearing all bits apart from c3 and shifting the 3rd bit 1 position right
	LDR R5, =0X8
	AND R5, R5, R1
	MOV R5, R5, LSR #1

	;Clearing all bits apart from c0 and c1  
	LDR R6, =0X3
	AND R6, R6, R1    


	;Adding the 4 registers together 
	ADD R1, R4, R5
	ADD R1, R1, R6       ; Final value

	
	SUB R1, R1, #1    ;;Subtracting 1 from R1 to determine the bit position of the error

	
	LDR R7, =0X1       ;Store tmp register with binary 1. Then moves the 1, 8 bit positions left. 
	
	MOV R7, R7, LSL R1

	
	EOR R0, R0, R7      ;Flips the bit in bit 8 of R0 and this is the corrected final result.


stop	B	stop

		ENDFUNC
		END
