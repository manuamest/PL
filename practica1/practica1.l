%{
#include <ctype.h>
#include <stdio.h>
int total_chars = 0;
int weird_words = 0;
int uppercase_words = 0;
int lowercase_words = 0;
int numeric_words = 0;
int total_sentences = 0;
int total_words = 0;
%}

word      [^ \t\n.]+
minus     [a-z]+
mayus     [A-Z]+
numeric   [0-9]+
sentence  \.
delim     [ \t\n]
ws        {delim}+

%%
{sentence}  { total_sentences++; total_chars++;}
{mayus}     { total_chars += yyleng; uppercase_words++; }
{minus}     { total_chars += yyleng; lowercase_words++; }
{numeric}   { total_chars += yyleng; numeric_words++; }
{word}      { total_chars += yyleng; weird_words++; }
{ws}        {}
%%

int main() {
    yylex();
    total_words = uppercase_words + lowercase_words + numeric_words + weird_words;
    printf("\nNúmero total de caracteres: %d\n", total_chars);
    printf("Número de palabras raras: %d\n", weird_words);
    printf("Número de palabras en mayúscula: %d\n", uppercase_words);
    printf("Número de palabras en minúscula: %d\n", lowercase_words);
    printf("Número de palabras numéricas: %d\n", numeric_words);
    printf("Número total de palabras: %d\n", total_words);
    printf("Número de frases: %d\n", total_sentences);
    return 0;
}