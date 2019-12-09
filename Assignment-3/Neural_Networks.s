
	THUMB
	PRESERVE8	
	AREA  Neural_Networks, CODE,READONLY
	EXPORT __main
	IMPORT printMsg
	IMPORT printMsg4p	
	IMPORT printMsg2p	
	IMPORT printp
		ENTRY

__main FUNCTION
	 
	 MOV R0,#0	         ;Logical_AND			
	 BL printp	
	 BL __andfunc
	 
	 MOV R0,#1           ;Logical_OR					
	 BL printp
	 BL __orfunc	
	 
	 MOV R0,#2           ;Logical_NOT
	 BL printp
	 BL __notfunc
	 
	 MOV R0,#3			 ;Logical_NAND
	 BL printp
	 BL __nandfunc
	 
	 MOV R0,#4			 ;Logical_NOR
	 BL printp
	 BL __norfunc
	 
	 B stop;
	 ENDFUNC	
		

__loadval FUNCTION
	 PUSH {LR};
	 VMOV.F32 S0,R4;			Move A1 to S0 (floating point register)
     VCVT.F32.S32 S0,S0; 		Convert into signed 32bit number
	 VMOV.F32 S1,R5;			Move A2 to S1 (floating point register)
     VCVT.F32.S32 S1,S1; 		Convert into signed 32bit number
	 VMOV.F32 S2,R6;			Move A3 to S2 (floating point register)
     VCVT.F32.S32 S2,S2; 		Convert into signed 32bit number
	 POP {LR};
	 BX lr;
	 ENDFUNC


__val FUNCTION
	 PUSH {LR};
	 BL __exp;					Compute e^-x
	 BL __sigmoid;				Sigmoid function output in S9
	 
	 VLDR.F32 S14,= 0.5;		Store 0.5 in S14
	 VCMP.F32 S9,S14;			Compare current Y and 0.5		
	 VMRS    APSR_nzcv, FPSCR;	 
	 MOV R0, R4;
	 MOV R1, R5;
	 MOV R2, R6;				Move inouts to R0, R1 and R2 to print
	 MOVGT	R3, #1;				If Y > 0.5, output is 1
	 MOVLT	R3, #0;				If Y < 0.5, output is 0
	 POP {LR};
	 BX lr;
	 ENDFUNC	 


__sigmoid FUNCTION
	 ;Compute sigmoid function e^-x in S11 and Sigmoid function output in S9
	 PUSH {LR};
	 VLDR.F32 S8,= 1;			Store #1 for calculations
	 VADD.F32 S9,S11,S8;		S9 has (e^-x)+1
	 VDIV.F32 S9,S8,S9;			S9 has 1 / (e^-x)+1		-> 	Value of Y - sigmoid function
	 POP {LR};	
	 BX lr;
	ENDFUNC
	


__exp FUNCTION
	 PUSH {LR};
	 ;                        Computing e^-x for value in S10 and store in S11	

	 ; S10 has value of x
	 VNEG.F32 S10,S10;			S10 has -x
	 
	 MOV R11,#200;				No of terms in the series
     MOV R12,#1;	    			Our Count
	 
     VLDR.F32 S11,=1;			Storing value of e^x
     VLDR.F32 S12,=1;			Temp variable to hold the previous term     
	 
LOOP1 
	 CMP R12,R11;			Compare count and no of term
     BLE LOOP2;				If count is < no. of terms enter LOOP1
	 POP {LR};	
     BX lr;						else STOP
	 
LOOP2  
	 VMUL.F32 S12,S12,S10; 		Temp_var = temp_var * x
     VMOV.F32 S13,R12;			Move the count in R9 to S13 (floating point register)
     VCVT.F32.S32 S13,S13; 		Convert into signed 32bit number
     VDIV.F32 S12,S12,S13;		Divide temp_var by count (Now the term is finished)
     VADD.F32 S11,S11,S12;		Add temp_var to the sum
     ADD R12,R12,#1;				Increment the count
     B LOOP1;
	 
	ENDFUNC		 


__val2 FUNCTION
	 PUSH {LR};
	 BL __exp;					Compute e^-x
	 BL __sigmoid;				Sigmoid function output in S9
	 
	 VLDR.F32 S14,= 0.5;		Store 0.5 in S14
	 VCMP.F32 S9,S14;			Compare current Y and 0.5		
	 VMRS    APSR_nzcv, FPSCR;	 
	 MOV R0, R4;
	 MOV R1, R5;
	 MOV R2, R6;				Move inouts to R0, R1 and R2 to print
	 MOVGT	R1, #1;				If Y > 0.5, output is 1
	 MOVLT	R1, #0;				If Y < 0.5, output is 0
	 POP {LR};
	 BX lr;
	 ENDFUNC	


;Logical_AND

__and FUNCTION
	 PUSH {LR};	 
	 VLDR.F32 S4,= -0.1;		W1
	 VLDR.F32 S5,= 0.2;			W2
	 VLDR.F32 S6,= 0.2;			W3
	 VLDR.F32 S7,= -0.2;	    Bias
	 
	 VMUL.F32 S0,S0,S4;			A1*W1
	 VMUL.F32 S1,S1,S5;			A2*W2
	 VMUL.F32 S2,S2,S6;			A3*W3
	 VADD.F32 S3,S0,S1;			A1*W1 + A2*W2 
	 VADD.F32 S3,S3,S2;			A1*W1 + A2*W2 + A3*W3 
	 VADD.F32 S3,S3,S7;			A1*W1 + A2*W2 + A3*W3 + B
	 
	 VMOV.F32 S10,S3;			S10 has the value of x
	 BL __val;
	 
	 POP {LR};	
	 BX lr;
	 ENDFUNC


;Logical_OR

__or FUNCTION
	 PUSH {LR};	 
	 VLDR.F32 S4,= -0.1;		W1
	 VLDR.F32 S5,= 0.7;			W2
	 VLDR.F32 S6,= 0.7;			W3
	 VLDR.F32 S7,= -0.1;		Bias
	 VMUL.F32 S0,S0,S4;			A1*W1
	 VMUL.F32 S1,S1,S5;			A2*W2
	 VMUL.F32 S2,S2,S6;			A3*W3
	 VADD.F32 S3,S0,S1;			A1*W1 + A2*W2 
	 VADD.F32 S3,S3,S2;			A1*W1 + A2*W2 + A3*W3 
	 VADD.F32 S3,S3,S7;			A1*W1 + A2*W2 + A3*W3 + B
	 
	 VMOV.F32 S10,S3;			so x is in S10
	 BL __val;
	 POP {LR};	
	 BX lr;
	 ENDFUNC


;Logical_NOT


__not FUNCTION
	 PUSH {LR};	 
	 VLDR.F32 S4,= -0.7;		W1
	 VLDR.F32 S7,= 0.1;			Bias
	 
	 VMUL.F32 S0,S0,S4;			A1*W1
	 VADD.F32 S3,S0,S7;			A1*W1 + B
	 
	 VMOV.F32 S10,S3;			S10 has the value of x
	 BL __val2;
	 POP {LR};	
	 BX lr;
	 ENDFUNC


;Logical_NAND

__nand FUNCTION
	 PUSH {LR};	 
	 VLDR.F32 S4,= 0.6;			W1
	 VLDR.F32 S5,= -0.8;		W2
	 VLDR.F32 S6,= -0.8;		W3
	 VLDR.F32 S7,= 0.3;			Bias
	 
	 VMUL.F32 S0,S0,S4;			A1*W1
	 VMUL.F32 S1,S1,S5;			A2*W2
	 VMUL.F32 S2,S2,S6;			A3*W3
	 VADD.F32 S3,S0,S1;			A1*W1 + A2*W2 
	 VADD.F32 S3,S3,S2;			A1*W1 + A2*W2 + A3*W3 
	 VADD.F32 S3,S3,S7;			A1*W1 + A2*W2 + A3*W3 + B
	 
	 VMOV.F32 S10,S3;			S10 has the value of x
	 BL __val;
	 POP {LR};	
	 BX lr;
	 ENDFUNC


;Logical_NOR

__nor FUNCTION
	 PUSH {LR};	 
	 VLDR.F32 S4,= 0.5;			W1
	 VLDR.F32 S5,= -0.7;		W2
	 VLDR.F32 S6,= -0.7;		W3
	 VLDR.F32 S7,= 0.1;			Bias
	 
	 VMUL.F32 S0,S0,S4;			A1*W1
	 VMUL.F32 S1,S1,S5;			A2*W2
	 VMUL.F32 S2,S2,S6;			A3*W3
	 VADD.F32 S3,S0,S1;			A1*W1 + A2*W2 
	 VADD.F32 S3,S3,S2;			A1*W1 + A2*W2 + A3*W3 
	 VADD.F32 S3,S3,S7;			A1*W1 + A2*W2 + A3*W3 + B
	 
	 VMOV.F32 S10,S3;			S10 has the value of x
	 BL __val;
	 POP {LR};	
	 BX lr;
	 ENDFUNC
	  	
	  
__andfunc FUNCTION	
	
	 PUSH {LR}; 
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#0;					A3
	 BL __loadval;
	 BL __and;
	 BL printMsg4p
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#1;					A3
	 BL __loadval;
	 BL __and;
	 BL printMsg4p
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#0;					A3
	 BL __loadval;
	 BL __and;
	 BL printMsg4p
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#1;					A3
	 BL __loadval;
	 BL __and;
	 BL printMsg4p
	 
	 POP {LR};	
     BX lr;						
	 					
	 ENDFUNC 
		 
__orfunc FUNCTION	
	
	 PUSH {LR}; 
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#0;					A3
	 BL __loadval;
	 BL __or;
	 BL printMsg4p
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#1;					A3
	 BL __loadval;
	 BL __or;
	 BL printMsg4p
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#0;					A3
	 BL __loadval;
	 BL __or;
	 BL printMsg4p
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#1;					A3
	 BL __loadval;
	 BL __or;
	 BL printMsg4p
	 
	 POP {LR};	
     BX lr;						
	 					
	 ENDFUNC 
	 
	 
__nandfunc FUNCTION	
	
	 PUSH {LR}; 
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#0;					A3
	 BL __loadval; 
	 BL __nand; 
	 BL printMsg4p;
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#1;					A3
	 BL __loadval; 
	 BL __nand; 
	 BL printMsg4p;
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#0;					A3
	 BL __loadval; 
	 BL __nand; 
	 BL printMsg4p;
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#1;					A3
	 BL __loadval; 
	 BL __nand; 
	 BL printMsg4p;
	 
	 POP {LR};	
     BX lr;						
	 					
	 ENDFUNC 


__norfunc FUNCTION	
	
	 PUSH {LR}; 
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#0;					A3
	 BL __loadval; 
	 BL __nor; 
	 BL printMsg4p;
	 
	 MOV R4,#1;					A1
	 MOV R5,#0;					A2
	 MOV R6,#1;					A3
	 BL __loadval; 
	 BL __nor; 
	 BL printMsg4p;
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#0;					A3
	 BL __loadval; 
	 BL __nor; 
	 BL printMsg4p;
	 
	 MOV R4,#1;					A1
	 MOV R5,#1;					A2
	 MOV R6,#1;					A3
	 BL __loadval; 
	 BL __nor; 
	 BL printMsg4p;
	 
	 POP {LR};	
     BX lr;						
	 					
	 ENDFUNC 
	 
__notfunc FUNCTION	
	
	 PUSH {LR}; 
	 MOV R4,#0;					A1
	 BL __loadval; 
	 BL __not; 
	 BL printMsg2p;
	 
	 
	 MOV R4,#1;					A1
	 BL __loadval; 
	 BL __not; 
	 BL printMsg2p;
	 
	 POP {LR};	
     BX lr;				
	 					
	 ENDFUNC  
	 
stop B stop
    END