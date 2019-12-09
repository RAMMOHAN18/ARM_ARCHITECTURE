#include "stm32f4xx.h"
#include <string.h>

void printMsg(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%x\n", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printMsg4p(const int a, const int b, const int c, const int d)
{
	 char Msg[100];
	 char *ptr;

	 //Printing the first parameter
	 sprintf(Msg, "%x\t", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\t", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\t", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\n", d);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
	 }
}

void printMsg2p(const int a, const int b)
{
	 char Msg[100];
	 char *ptr;

	 //Printing the first parameter
	 sprintf(Msg, "%x\t", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 // Printing the message
	 sprintf(Msg, "%x\n", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printp(const int a)
{
char *ptr_n;
	 
	if(a==0){ ptr_n = "Logic Function: AND\nX0\tX1\tX2\tY\n"; }
	 if(a==1){ ptr_n = "\nLogic Function: OR\nX0\tX1\tX2\tY\n"; }
	 if(a==2){ ptr_n = "\nLogic Function: NOT\nX\tY\n"; }
	 if(a==3){ ptr_n = "\nLogic Function: NAND\nX0\tX1\tX2\tY\n"; }
	 if(a==4){ ptr_n = "\nLogic Function: NOR\nX0\tX1\tX2\tY\n"; }
	 
	
	 while(*ptr_n != '\0'){
      ITM_SendChar(*ptr_n);
      ++ptr_n;
   }
	 return;}