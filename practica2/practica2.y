%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char* s);
int lines = 0;
%}

%token <string> OPEN_TAG CLOSE_TAG COMMENT DECLARATION CONTENT

%union {
    char* str;
}

%%

start:
      DECLARATION COMMENT tags {printf("Sintaxis XML correcta.\n");}
	| DECLARATION COMMENT tags COMMENT {printf("Sintaxis XML correcta.\n");}
	| DECLARATION tags COMMENT {printf("Sintaxis XML correcta.\n");}
	| DECLARATION tags {printf("Sintaxis XML correcta.\n");}

tags:
	 OPEN_TAG content CLOSE_TAG {
		
		if (strcmp($1+1, $3+2) != 0){
	printf("Error en línea %d: Encontrado: '%s' y se esperaba '%s'.\n", lines, $3, $1);
		
			exit(2);
		}
	}
	| OPEN_TAG CLOSE_TAG {
	
	if (strcmp($1+1, $2+2) != 0){
	
	printf("Error en línea %d: Encontrado: '%s' y se esperaba '%s'.\n", lines, $2, $1);
		
	exit(2);
		}
	}
	| OPEN_TAG CLOSE_TAG OPEN_TAG {
		
		
		printf("Error en línea %d: No existe el tag raíz.\n",  lines);
		exit(2);
	}
	| OPEN_TAG content CLOSE_TAG OPEN_TAG {
		
		printf("Error en línea %d: No existe el tag raíz.\n",  lines);
		exit(2);
	}
	;

content: data
	| data content
	| OPEN_TAG content CLOSE_TAG {
		
		if (strcmp($1+1, $3+2) != 0){
	printf("Error en línea %d: Encontrado: '%s' y se esperaba '%s'.\n", lines, $3, $1);
		
		exit(2);
		}
	}
	| OPEN_TAG content CLOSE_TAG content {
		
			if (strcmp($1+1, $3+2) != 0){
	printf("Error en línea %d: Encontrado: '%s' y se esperaba '%s'.\n", lines, $3, $1);
		
			exit(2);
		}
	}
	;

data: OPEN_TAG CLOSE_TAG
	| CONTENT {lines++;}
	| COMMENT{lines++;}
;

%%

int main(int argc, char *argv[]) {

    yyparse();

    return 0;
}
