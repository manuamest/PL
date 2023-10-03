%{
#include <ctype.h>
#include <stdio.h>
int total_chars = 0;
int words = 0;
int uppercase_words = 0;
int lowercase_words = 0;
int numeric_words = 0;
int total_sentences = 0;
%}

word [^ \t\n.]+
minus [a-z]+
mayus [A-Z][a-zA-Z]+
numeric [0-9][0-9]+

%%
\.  { total_sentences++; }
{mayus}     { total_chars += yyleng; uppercase_words++; }
{minus}     { total_chars += yyleng; lowercase_words++; }
{numeric}   { total_chars += yyleng; numeric_words++; }
{word}      { total_chars += yyleng; words++; }
%%

int main() {
    yylex();
    printf("\nNúmero total de caracteres: %d\n", total_chars);
    printf("Número de palabras: %d\n", words);
    printf("Número de palabras en mayúscula: %d\n", uppercase_words);
    printf("Número de palabras en minúscula: %d\n", lowercase_words);
    printf("Número de palabras numéricas: %d\n", numeric_words);
    printf("Número de frases: %d\n", total_sentences);
    return 0;
}