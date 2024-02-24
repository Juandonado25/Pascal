{1.- Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada
una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno
11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número
de alumno y promedio de cada alumno.
c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}

program p0e1;

//Types & constants

const cantNotasMax = 36;

type vecNotas = array [1..cantNotasMax] of integer;
	
	infoAlu = record
		apellido: string;
		numero: integer;
		anio: integer;
		cantAprob: integer;
		notas: vecNotas;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: infoAlu;
		sig: lista;
	end;

//Procedures & Functions

procedure leerNotas (var v:vecNotas; diml:integer);
	var
		i,n:integer;
	begin
		for i:=1 to diml do begin
			write('Ingrese la nota de la materia ',i,': ');
			readln(n);
			v[i]:=n;
		end;
	end;
	
procedure leerInfoAlu (var r:infoAlu);
	begin
		writeln('Ingrese los datos del alumno.');
		write('Apellido:');
		readln(r.apellido);
		write('Numero de alumno:');
		readln(r.numero);
		write('Anio:');
		readln(r.anio);
		write('Cantidad de materias aprobadas:');
		readln(r.cantAprob);
		leerNotas(r.notas, r.cantAprob);
	end; 
	
procedure insertNodo (var l:lista);
	var
		nuevo:lista; r:infoAlu;
	begin
		leerInfoAlu(r);
		new(nuevo);
		nuevo^.dato:=r;
		nuevo^.sig:=l;
		l:=nuevo;
	end;
	
procedure crearLista (var l:lista);
	begin
		repeat
			insertNodo(l);
		until (l^.dato.numero = 11111);
	end;
	
function promedio (v:vecNotas; diml:integer):real;
	var
		sum,i:integer;
	begin
		sum:=0;
		for i:=1 to diml do
			sum:=sum+v[i];
		promedio:=sum/diml;
	end;
	
procedure numProm (l:lista);
	begin
		while (l <> nil) do begin
			writeln('numero: ', l^.dato.numero);
			writeln('promedio: ', promedio(l^.dato.notas, l^.dato.cantAprob):2:2);
			l:=l^.sig;
		end;
	end;

//Principal

VAR
	L:lista;
	
BEGIN
	L := nil;
	crearLista(L);
	numProm(L);
END.

{Para responder el inciso c. Yo cambiaria el vector donde se guardan las notas
* y usaria una lista.}
