%{
#include <ctype.h>
#include <stdio.h>
int total_chars = 0;
int total_words = 0;
int uppercase_words = 0;
int lowercase_words = 0;
int numeric_words = 0;
int total_sentences = 0;
int is_numeric = 1;
int in_sentence = 0;
%}

word [^ \t\n]+

%%
{word}       { total_chars += yyleng; total_words++; 
                  if (isupper(yytext[0])) uppercase_words++;
                  if (islower(yytext[0])) lowercase_words++;
                  is_numeric = 1;
                  for (int i = 0; yytext[i]; i++) {
                    if (!isdigit(yytext[i])) {
                      is_numeric = 0;
                      break;
                    }
                  }
                  if (is_numeric) numeric_words++;
                }
[^.]*\.\s*      { if(in_sentence) total_sentences++;}
\n              { /* Ignora saltos de línea */ }
.               { /* Caracter no reconocido */ }
%%

int main() {
    yylex();
    printf("Número total de caracteres: %d\n", total_chars);
    printf("Número total de palabras: %d\n", total_words);
    printf("Número de palabras en mayúscula: %d\n", uppercase_words);
    printf("Número de palabras en minúscula: %d\n", lowercase_words);
    printf("Número de palabras numéricas: %d\n", numeric_words);
    printf("Número de frases: %d\n", total_sentences);
    return 0;
}
