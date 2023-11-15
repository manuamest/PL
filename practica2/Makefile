### PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l y .y
FUENTE = practica2
# PRUEBA: nombre fichero de prueba
PRUEBA = prueba5.xml
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile run

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd -r all
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -ly

run:
	./$(FUENTE) < $(PRUEBA)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h

run1:
	./$(FUENTE) < prueba1.xml
run2:
	./$(FUENTE) < prueba2.xml
run3:
	./$(FUENTE) < prueba3.xml
run4:
	./$(FUENTE) < prueba4.xml
run5:
	./$(FUENTE) < prueba5.xml