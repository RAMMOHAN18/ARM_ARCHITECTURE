     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION
		MOV R1,#5	            ;Moving the given number(Which is to be checked for EVEN or ODD)into the register R1
		AND R2,R1,#1	        ;Performing Logical AND operation between given number and the number '1'.[If result = 1 , number is odd , else even]
		MOV  R4, #0x20000000    ;Memory location
		STR R2,[R4]             ;Either 0 or 1 is stored in memory location R4 so that number is judged as Even or Odd
stop    B stop                  ; stop program
     ENDFUNC
     END 
	 
	 
	 
	 