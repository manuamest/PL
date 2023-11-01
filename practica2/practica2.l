%{
#include "practica2.tab.h"
%}

string [A-Z | 0-9 | a-z]+


%%

"<\\?xml" { return XML; }
"version=\"1.0\"" { return VERSION; }
"encoding=\"UTF-8\"\\?>" { return ENCODING; }
"<"{string}">" { return OPEN_TAG; }
"</"{string}">" { return CLOSE_TAG; }
.|\n { }

%%

int yywrap() {
    return 1;
}
