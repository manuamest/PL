%{
int count = 0; // Variable para contar las palabras que comienzan con mayúscula
%}

%%
[A-Z][a-zA-Z]+ { count++; } // Coincide con palabras que comienzan con mayúscula

.|\n { } // Ignorar otros caracteres

%%

int main() {
    yylex();
    printf("Número de palabras que comienzan con mayúscula: %d\n", count);
    return 0;
}
