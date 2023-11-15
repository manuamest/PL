### PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l
FUENTE = practica1
# PRUEBA: nombre fichero de prueba
PRUEBA = prueba1.txt
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile

compile:
	flex $(FUENTE).l
	gcc -o $(FUENTE) lex.yy.c -$(LIB)

clean:
	rm $(FUENTE) lex.yy.c 

run:
	./$(FUENTE) < $(PRUEBA)

run1:
	./$(FUENTE) < prueba1.txt

run2:
	./$(FUENTE) < prueba2.txt

run3:
	./$(FUENTE) < prueba3.txt

run4:
	./$(FUENTE) < prueba4.txt

run5:
	./$(FUENTE)
