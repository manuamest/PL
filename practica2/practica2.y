%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char* s);
extern int yylineno;

%}

%token <string> OPEN_TAG CLOSE_TAG COMMENT DECLARATION CONTENT

%union {
    char* string;
}

%%

start:
	  DECLARATION comment OPEN_TAG content CLOSE_TAG comment {
		printf("\nSintaxis XML correcta.\n");}
    | error {
        printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
        exit(1);}
;

comment: /*vacio*/
		| COMMENT
;

content: data
	| content data
	| OPEN_TAG content CLOSE_TAG {
		if (strcmp($1+1, $3+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", yylineno, $3, $1+1);
		    exit(1);
		}
	}
	| content OPEN_TAG content CLOSE_TAG {
		if (strcmp($2+1, $4+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", yylineno, $4, $2+1);
			exit(1);
		}
	}
;

data: OPEN_TAG CLOSE_TAG
	| CONTENT 
	| COMMENT
;

%%

int main(int argc, char *argv[]) {
	yyparse();
	return 0;
}