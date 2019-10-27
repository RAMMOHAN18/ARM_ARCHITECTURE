     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION
		MOV R1,#12	                ;Moving First Number into the register R1
		MOV R2,#4	                ;Moving Second Number into the register R2
		MOV R3,#25	                ;Moving Third Number into the register R3
		MOV  R4, #0x20000000        ;Memory Location
		CMP R1,R2                   ;Compare R1 and R2
		MOVLT R1,R2                 ;If R1 < R2 , then move R2 value to R1
		CMP R1,R3                   ;Now new R1 and R3 are Compared
		MOVLT R1,R3                 ;If R1 < R3 , then move R3 to R1 so that greatest number is finally moved to R1
		STR R1,[R4]                 ;Now the greatest number R1 is stored in memory location R4
stop    B stop                      ;stop program
     ENDFUNC
     END 
	 
	 
	