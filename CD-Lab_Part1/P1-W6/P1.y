%{
    #include<stdio.h>  
    #include<string.h> 
    int yydebug;
    int parseError = 0;
    extern int yylex();
    extern int yyerror();
    
%}
%union{
char* str;    
}

%token<str> HASHDEFINE
%token<str> NOT 
%token<str> CURLY_OPEN 
%token<str> CURLY_CLOSE
%token<str> PAR_OPEN
%token<str> PAR_CLOSE
%token<str> SQR_CLOSE
%token<str> IF
%token<str> WHILE 
%token<str> CLASS
%token<str> PUBLIC
%token<str> STATIC
%token<str> VOID
%token<str> MAIN 
%token<str> STR
%token<str> PRINTLN
%token<str> EXTENDS
%token<str> THIS
%token<str> NEW
%token<str> SEMI_COLON
%token<str> COMMA
%token<str> LENGTH
%token<str> TRUE
%token<str> FALSE 
%token<str> NUMBER 
%token<str> RET
%token<str> BOOL INT IDENTIFIER ADD SUB MUL DIV MOD AND LEQ NEQ SQR_OPEN DOT ASSIGNMENT ELSE 

%nonassoc label newlabel lab1 
%nonassoc ELSE 
%left BOOL INT IDENTIFIER
%left ADD SUB MUL DIV MOD AND LEQ  NEQ SQR_OPEN DOT
%right ASSIGNMENT

%type<str> Goal MainClass 
%type<str> ExpOneZero Exp Expression PrimaryExpression Identifier
%%

Goal: MainClass TypeDec;

 
MainClass : CLASS Identifier CURLY_OPEN PUBLIC STATIC VOID MAIN PAR_OPEN
	  STR SQR_OPEN SQR_CLOSE Identifier PAR_CLOSE CURLY_OPEN PRINTLN PAR_OPEN Expression PAR_CLOSE SEMI_COLON CURLY_CLOSE CURLY_CLOSE ;

TypeDec : ;

ExpOneZero:	
|Expression Exp
;

Exp: 	
| Exp COMMA Expression 
; 

Expression: PrimaryExpression AND PrimaryExpression 
|   PrimaryExpression LEQ PrimaryExpression 
|   PrimaryExpression NEQ PrimaryExpression 
|   PrimaryExpression ADD PrimaryExpression      
|   PrimaryExpression SUB PrimaryExpression	 
|   PrimaryExpression MUL PrimaryExpression	 
|   PrimaryExpression DIV PrimaryExpression	 
|   PrimaryExpression SQR_OPEN PrimaryExpression SQR_CLOSE 
|   PrimaryExpression DOT LENGTH		 
|   PrimaryExpression %prec newlabel            
|   PrimaryExpression DOT Identifier PAR_OPEN ExpOneZero PAR_CLOSE

;

PrimaryExpression : NUMBER  
|   TRUE		    
|   FALSE		    
|   Identifier		    
|   THIS		    
|   NEW INT SQR_OPEN Expression SQR_CLOSE 
|   NEW Identifier PAR_OPEN  PAR_CLOSE	  
|   NOT Expression			  
|   PAR_OPEN Expression PAR_CLOSE	  
;

Identifier: 
IDENTIFIER 
%%
main (int argc, char **argv) {
     yyparse();
     if (!parseError) {
      	printf("Program parsed successfully. \n");
     }
}
yyerror (char *s) {
      parseError = 1;
      printf("Syntax error. \n");
}
