%%
username	{printf("%s", getlogin() );}
exit        {return 0;}
[0-9]+      {}
[A-Za-z]+   {printf(">Regla 4\n");}
.+          {printf(">Regla 5\n");}
%%
int main() {
        yylex();
        return 0;
}
