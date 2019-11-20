 AREA     Circle, CODE 
      IMPORT   printMsg
      IMPORT   printMsg2p		  
      EXPORT __main
      ENTRY 
__main  FUNCTION
	VLDR.F32 S31, =3.14159 ; storing Pi value 
	VLDR.F32 S30, =180 ; 
	VDIV.F32 S29,S31,S30 ; Pi/180
	VLDR.F32 S1,=0 ; angle in degrees
	VLDR.F32 S16,=10 ; No of terms in a series 
	MOV R3,#1 ; counting variable i
	MOV R4,#10;
	VLDR.F32 S18,=0;
	VLDR.F32 S19,=1;
	VLDR.F32 S24,=50;    Radius of circle
	VLDR.F32 S27,=320;   X Coordinate of mid point
	VLDR.F32 S28,=240;   Y Coordinate of mid point
	MOV  R0, #0x20000000  ; Memory location to store the result
	STR R3,[R0]
    ;MOV  R3, #0x20000001  ; Memory location to store the result
	;STR R4,[R0]

Angle   CMP R2,#40		;Compare 'i' and 'n' 
		BLE ORDINATES		;if i < n goto LOOP
        B   stop
		
ORDINATES	
		    BL cosine
		    VMUL.F32 S9,S24,S9
		   ;VCVT.U32.F32 S9,S9
		    VADD.F32 S9,S9,S27
		    VMOV.F32 R0,S9;
		    BL printMsg
			
			BL sine  
            VMUL.F32 S0,S24,S0
		   ;VCVT.U32.F32 S0,S0
		   ;VADD.F32 S0,S0,S17;
		    VADD.F32 S0,S0,S28
		    VMOV.F32 R0,S0;
		    BL printMsg
			
			
		    VLDR.F32 S17,=10;
		    VADD.F32 S1,S1,S17;
		   ;VADD.F32 S18,s18,s19;
		   ;VMOV.F32 R3,S18;
		   ;VMOV.F32 R4,S16;
		    MOV  R0, #0x20000000  ; Memory location to store the result
	        LDR R2,[R0]
		    ADD R2,R2,#1;
		    STR R2,[R0]
		    B Angle
		   ;B  stop
;angle	
sine     VMUL.F32 S2,S1,S29 ; (pi/180)*angle - given angle is converted to radians 

	    VMUL.F32 S3,S2,S2 ; x*x

	    VLDR.F32 S4,=2 ; to calculate 2*i and ((2*i)+1)

	    VLDR.F32 S5,=1; i value
	    VLDR.F32 S6,=1; increment

	    MOV R0,#10 ; No of terms in a series 

	    MOV R1,#1 ; counting variable i

	    VMOV.F32 S11,S2
	    VMOV.F32 S0,S2 

COUNT   CMP R1,#10   ;R0		;Compare 'i' and 'n' 
		BLE LOOP		;if i < n goto LOOP
		VMOV.F32 S22,S0
		BX  lr
		;B stop			;else goto stop
			
LOOP    VMUL.F32 S7,S4,S5	; 2*i
		VADD.F32 S8,S7,S6	; (2*i)+1
		VNMUL.F32 S9,S11,S3
		VDIV.F32 S10,S9,S7
		VDIV.F32 S11,S10,S8
		VADD.F32 S0,S0,S11	;Finally add 's' to 't' and store it in 's'
		VADD.F32 S5,S5,S6
		ADD R1,R1,#1		;Increment the counter variable 'i'
		B COUNT				;Again goto comparision
			

cosine     VMUL.F32 S2,S1,S29 ; (pi/180)*angle - given angle is converted to radians
        VMUL.F32 S3,S2,S2 ; x*x

		VLDR.F32 S4,=2 ; to calculate 2*i, ((2*i)+1) and ((2*i)-1)

		VLDR.F32 S5,=1; i value
		VLDR.F32 S6,=1; increment

		MOV R0,#10 ; No of terms in a series 

		MOV R1,#1 ; incrementing value

	
		VLDR.F32 S9,=1 ; Cosx final value is stored in S9
		VLDR.F32 S15,=1	; Using S15 to store the intermediate result of cosx

COUNT1  CMP R1,#10   ;R0			;Compare 'i' and 'n' 
		BLE LOOP1			;if i < n goto LOOP
		BX  lr
		;B stop				;else goto stop
			
LOOP1   VMUL.F32 S7,S4,S5	; 2*i
		VADD.F32 S8,S7,S6	; (2*i)+1
		VSUB.F32 S12,S7,S6	; (2*i)-1
		
		;Calculating next term for cosx
		VNMUL.F32 S13,S15,S3; 
		VDIV.F32 S14,S13,S7
		VDIV.F32 S15,S14,S12
		
		
		
		VADD.F32 S9,S9,S15 ;Adding the new term to the previous result 
		
		
		VADD.F32 S5,S5,S6   ;incrementing i value
		
		
		ADD R1,R1,#1		    ;Increment the counter variable 'i'
		B COUNT1				;Again goto comparision



stop    B stop
		ENDFUNC
		END 
