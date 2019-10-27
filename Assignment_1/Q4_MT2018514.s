
	THUMB
	 AREA     factorial, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
     MOV R1,#0x00000020
	 MOV R2,#0x00000024
	 MOV R3,#0x00000010
	 CMP R1,R2
     ITTE GE
	 CMPGE R1,R3
	 ITEGE GE
	 MOVGE R4,R1
	 MOVLT R4,R3
	 CMPLT R2,R3
     ITELT GE
	 MOVGE R4,R1
	 MOVLT R4,R3

stop    B stop ; stop program
     ENDFUNC
     END 
	 

; We CAN'T DO nested IF-Then else in CORTEX –M4 because of following errors

	 
;Build started: Project: first
;*** Using Compiler 'V5.06 update 6 (build 750)', folder: 'C:\Keil_v5\ARM\ARMCC\Bin'
;Build target 'Target 1'
;assembling startup_stm32f407xx.s...
;assembling first.s...
;first.s(13): error: A1163E: Unknown opcode ITEGE , expecting opcode or Macro
;first.s(17): error: A1163E: Unknown opcode ITELT , expecting opcode or Macro
;compiling system_stm32f4xx.c...
;".\Objects\first.axf" - 2 Error(s), 0 Warning(s).
;Target not created.
	 
 
  
	 
 
 