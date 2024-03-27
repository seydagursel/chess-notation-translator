%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int linenum=1;
%}
%%


[0-9]+ {
		yylval.number =atoi(yytext);
		return BLOCKNUM;
}
[A-Z] {

		yylval.str= strdup(yytext);
		return SYMBOL;
}

[a-h] {

		yylval.str = strdup(yytext);
		return BLOCK;
}

"."   return DOT;
"-"	{yylval.str = strdup(yytext);return MOVE;}
"+"   {yylval.str = strdup(yytext);return CHECK;}
"x"   {yylval.str = strdup(yytext);return CAPTURES;}
"#"   {yylval.str = strdup(yytext);return CM;}
"O-O-O" {yylval.str = strdup(yytext);return CQS;}
"O-O"  {yylval.str = strdup(yytext);return CKS;}
"\n" linenum++;
.   {}

%%
