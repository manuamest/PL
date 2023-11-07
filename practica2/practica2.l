%{
#include <stdlib.h>
#include "practica2.tab.h"
%}

%option yylineno

identificador   [A-Za-zÁÉÍÓÚáéíóú0-9]+
contenido       ([A-Za-zÁÉÍÓÚáéíóú0-9]+|[-\/\!\?¿¡\(\)''#\"\$\%\*\-\.,:=])*

%%
[ \t\n]+                        {}                     
"<!--"[^-]*"-->"                { yylval.string=strdup(yytext); return COMMENT;}
"<?"({contenido}|\=|.|-)*"?>"   { yylval.string=strdup(yytext); return DECLARATION;}
"<"{identificador}">"           {  yylval.string=strdup(yytext); return OPEN_TAG;}
"</"{identificador}">"          { yylval.string=strdup(yytext); return CLOSE_TAG;}
{contenido}                     { yylval.string=strdup(yytext); return CONTENT;}

%%
