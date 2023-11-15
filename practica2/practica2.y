%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char* s);
extern int yylineno;

%}

%token <string> OPEN_TAG CLOSE_TAG COMMENT DECLARATION CONTENT
%token PLUS MINUS

%left PLUS MINUS

%union {
    char* string;
}

%%

start:
	DECLARATION comment OPEN_TAG content CLOSE_TAG comment YYEOF {
		if (strcmp($3+1, $5+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", --yylineno, $5, $3+1);
		    exit(1);
		}
		printf("\nSintaxis XML correcta.\n");
		return 0;}
	| DECLARATION comment OPEN_TAG content CLOSE_TAG comment OPEN_TAG {
		printf("\nSintaxis XML incorrecta. Falta el tag raiz.\n");
		exit(2);}
	| comment OPEN_TAG content CLOSE_TAG comment YYEOF {
		printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
		exit(2);}
    | error {
        printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
        exit(3);}
;

comment: /* empty */
		| COMMENT
;

content: data
	| content data
	| OPEN_TAG content CLOSE_TAG text  {
		if (strcmp($1+1, $3+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", yylineno, $3, $1+1);
			exit(1);
		}
	}
	| content OPEN_TAG content CLOSE_TAG text  {
		if (strcmp($2+1, $4+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", yylineno, $4, $2+1);
			exit(1);
		}
	}
;

text: /* empty */%prec MINUS
	 | CONTENT %prec PLUS {
	    printf("\nSintaxis XML incorrecta. Error en línea %d: Texto fuera de los tags.\n", yylineno);
		exit(4);
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