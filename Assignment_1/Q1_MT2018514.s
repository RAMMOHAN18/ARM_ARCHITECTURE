     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION		
    MOV R0,#0	              ;Moving initial number 0 into the register R0
    MOV R1,#1	              ;Moving initial number 1 into the register R1
    MOV R3,#10	              ;Maximum limit upto which the fibonacci series need to be calculated
    MOV R4,#0	              ;Moving initial number 0 into the register R0
    MOV R5,#0x20000000	      ;Memory location
    ADD R4,R0,R1	          ;Adding R0 and R1 to generate next number in the series and stored in R4
loop1 CMP R4,R3               ;Comparing R4 with R3 whether it exceed the limit provided
    BLE loop2                 ;If R4 is less than R3 go to loop2 
    B stop                    ;Else stop program
loop2 STR R4,[R5],#1          ;To Store the fibonacci series into memory
    MOV R0,R1		          ;Moving R1 to R0
    MOV R1,R4		          ;Moving R4 to R1
    ADD R4,R0,R1	          ;Adding R0 and R1 to generate next number in the series and stored in R4
    B loop1			          ;go to loop1 
stop    B stop 		          ; stop program
     ENDFUNC
     END 
	 
	 
	 
	 
	
