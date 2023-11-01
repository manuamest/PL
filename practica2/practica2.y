%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char* s);
extern int lines;
extern int yylineno;

%}

%token <string> OPEN_TAG CLOSE_TAG COMMENT DECLARATION CONTENT

%union {
    char* string;
}

%%

start:
      DECLARATION COMMENT tags {printf("\nSintaxis XML correcta.\n");}
    | DECLARATION tags COMMENT {printf("\nSintaxis XML correcta.\n");}
	| DECLARATION COMMENT tags COMMENT {printf("\nSintaxis XML correcta.\n");}
	| DECLARATION tags {printf("\nSintaxis XML correcta.\n");}
    | COMMENT tags COMMENT {
        printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
        exit(1);}
    | COMMENT tags {
        printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
        exit(1);}
    | tags COMMENT{
        printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
        exit(1);}
    | tags {
        printf("\nSintaxis XML incorrecta. Falta la cabecera.\n");
        exit(1);}
;

tags:
	 OPEN_TAG content CLOSE_TAG {
		printf("\nlineno %d\n", yylineno);
		if (strcmp($1+1, $3+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", lines, $3, $1+1);
			exit(1);
		}
	}
	| OPEN_TAG CLOSE_TAG {
		printf("\nlineno %d\n", yylineno);
	    if (strcmp($1+1, $2+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", lines, $2, $1+1);
	        exit(1);
		}
	}

	/*
	| OPEN_TAG CLOSE_TAG OPEN_TAG {
		printf("\nSintaxis XML incorrecta. Error en línea %d: No existe el tag raíz.\n",  lines);
		exit(1);
	}
	| OPEN_TAG content CLOSE_TAG OPEN_TAG {
		printf("\nSintaxis XML incorrecta. Error en línea %d: No existe el tag raíz.\n",  lines);
		exit(1);
	}*/
;

content: data
	| data content
	| OPEN_TAG content CLOSE_TAG {
		printf("\nlineno1 %d\n", yylineno);
		if (strcmp($1+1, $3+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", lines, $3, $1+1);
		    exit(1);
		}
	}
	| OPEN_TAG content CLOSE_TAG content {
		printf("\nlineno2 %d\n %s %s", yylineno, $1, $3);
			if (strcmp($1+1, $3+2) != 0){
	        printf("\nSintaxis XML incorrecta. Error en línea %d: Encontrado: \"%s\" y se esperaba \"</%s\".\n", lines, $3, $1+1);
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