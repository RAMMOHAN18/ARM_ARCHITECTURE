     AREA     factorial, CODE, READONLY
     EXPORT __main
     IMPORT printMsg
     ENTRY 
__main  FUNCTION	

      VLDR.F32 S1,=0 ; starting angle

		

  
ORDINATES  VMOV.F32 S24 , S1
		   VLDR.F32 S22,=360 ; Final angle 
		   VLDR.F32 S23,=1 ; angle increment by 1
           VADD.F32 S1,S24,S23 ; incrementing S1 from 0 to 360
		   
		   
		   ;Degrees to Radian Conversion
	
	VLDR.F32 S31, =3.14159 ; storing Pi value 
	VLDR.F32 S30, =180 ; 
	VDIV.F32 S29,S31,S30 ; Pi/180
	VMUL.F32 S2,S1,S29 ; (pi/180)*angle - given angle is converted to radians 

;Every term has to be multiplied by x^2 for next iteration 
	VMUL.F32 S3,S2,S2 ; x*x

	VLDR.F32 S4,=2 ; to calculate 2*i, ((2*i)+1) and ((2*i)-1)

	VLDR.F32 S5,=1; i value
	VLDR.F32 S6,=1; increment

	MOV R0,#10 ; No of terms in a series 

	MOV R1,#1 ; counting variable n (To repeat the loop)

	VMOV.F32 S11,S2 ; Using S11 to store the intermediate result of sinx
	VMOV.F32 S0,S2	; Sinx result is stored in s0 register 
	VLDR.F32 S20,=1 ; Cosx  result is stored in s20 register
	VLDR.F32 S15,=1	; Using S15 to store the intermediate result of cosx

COUNT   CMP R1,R0			;Compare 'i' and 'n' 
		BLE LOOP			;if i < n goto LOOP
		
		B ORDINATES				;else goto stop
			
LOOP    VMUL.F32 S7,S4,S5	; 2*i
		VADD.F32 S8,S7,S6	; (2*i)+1
		VSUB.F32 S12,S7,S6	; (2*i)-1
		
		;Calculating next term for sinx 
		VNMUL.F32 S9,S11,S3	; 
		VDIV.F32 S10,S9,S7
		VDIV.F32 S11,S10,S8
		
		;Calculating next term for cosx
		VNMUL.F32 S13,S15,S3; 
		VDIV.F32 S14,S13,S7
		VDIV.F32 S15,S14,S12
		
		;Adding the new term to the previous result 
		VADD.F32 S0,S0,S11	; (for sinx)
		VADD.F32 S20,S20,S15; (for cosx)
		
		;incrementing i value
		VADD.F32 S5,S5,S6
		
		
		 VMOV.F32 R0,S0
		    BL printMsg
		   VMOV.F32 R1,S20	
       
           BL printMsg	 ; Refer to ARM Procedure calling standards.
		   
		
		
		ADD R1,R1,#1		;Increment the counter variable 'i'
		B COUNT				;Again goto comparision
		   
		   
		   
		   
		   
		   
		  
		   VCMP.F32 S1,S22			;Compare 'i' and 'n' 
		   BLE ORDINATES			;if i < n goto LOOP
	
		   B stop				;else goto stop
	
		
		
			
stop    B stop
		ENDFUNC
		END 

