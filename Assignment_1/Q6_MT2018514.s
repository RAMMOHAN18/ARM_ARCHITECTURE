     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION
		MOV R1,#6	           ;The number 'a' is moved to register R1
		MOV R2,#21	           ;The number 'b' is moved to register R2		
GCD    CMP R1,R2               ;Compare the two values stored in register
		SUBGT R1,R1,R2         ;If R1 > R2 , then this substraction should be done
		SUBLT R2,R2,R1         ;If R1 < R2 , then this substraction should be done
		BNE    GCD             ;Until the difference is zero , repeat this loop
stop    B stop                 ;stop program
     ENDFUNC
     END 
	 
	 
	 