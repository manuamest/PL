%{
#include <stdio.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%token XML VERSION ENCODING OPEN_TAG CLOSE_TAG TEXT

%%

start: prolog element
    ;

prolog: XML VERSION ENCODING
    ;

element: OPEN_TAG content CLOSE_TAG
    ;

content: element content
    | TEXT content
    | /* empty */
    ;

%%

void yyerror(const char* s) {
   printf("Error: %s\n", s);
}

int main(void) {
   FILE* inputFile = fopen("practica2_ejemplo1.xml", "r");
   if (!inputFile) {
      printf("Error opening file\n");
      return -1;
   }

   yyin = inputFile;

   do {
      yyparse();
   } while (!feof(yyin));

   return 0;
}
