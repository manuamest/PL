### PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l
FUENTE = practica2
# PRUEBA: nombre fichero de prueba
PRUEBA = practica2_ejemplo2.xml
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile run

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -ly

run:
	./$(FUENTE) < $(PRUEBA)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
