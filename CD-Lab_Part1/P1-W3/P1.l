%{
#include "P1.tab.h"   
#include<stdio.h>
#include<stdlib.h>
%}

%%
 /* Write code to ignore empty spaces and newlines.   */
 /* Write code to ignore comments (single line and multiline).   */
 /* Write code to scan all the operators, paranthesis etc. Example shown *below. */
"="                     {char* str=yytext;printf ("%s %d\n", str, ASSIGNMENT);}
  /* Write code to scan all the keywords. Example shown below. */
"if"                    {char* str=yytext;printf ("%s %d\n", str, IF);} 
 /* Write code to scan all the punctuations. Example shown below. */
 /* Write code to scan numbers and identifiers.  */
 /* Write code to throw error if you encounter any invalid token. */
%%

int main(){
 yylex();
}
