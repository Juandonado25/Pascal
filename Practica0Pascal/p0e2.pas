{2.- Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria.
Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido.}

program p0e2;

type
	tipoZona = 1..5;
	
	infoProp = record
		cod:integer;
		tipo:integer;
		precio:real;
	end;
	
	listaProp = ^nodo;
	nodo = record
		dato:infoProp;
		sig:listaProp;
	end;
	
	vecZona = array [tipozona] of listaProp;

//Procedures & Functions

	procedure leerProp (var r:infoProp; var z:tipoZona; var ok:boolean);
		var
			m,pm:real;
		begin
			writeln('Ingrese los datos de la propiedad a almacenar.');
			write('Tipo de zona (del 1 al 5): ');
			readln(z);
			write('Codigo de la propiedad: ');
			readln(r.cod);
			write('Tipo de propiedad: ');
			readln(r.tipo);
			write('Metros cuadrados de la propiedad: ');
			readln(m);
			write('Precio del metro cuadrado: ');
			readln(pm);
			if (pm <> -1) then
				r.precio:=m*pm
			else 
				ok := false;
		end;

	procedure insertarOrdenado (var l:listaProp; r:infoProp);
		var
			nuevo,ant,act:listaProp;
		begin
			new(nuevo);
			nuevo^.dato:=r;
			nuevo^.sig:=nil;
			if (l=nil) then
				l:=nuevo
			else begin
				ant:=l;
				act:=l;
				while (act<>nil) and (act^.dato.tipo < nuevo^.dato.tipo) do begin
					ant:=act;
					act:=act^.sig;
				end;
				if (l = act) then begin
					nuevo^.sig:=l;
					l:=nuevo;
				end
				else begin
					ant^.sig:=nuevo;
					nuevo^.sig:=act;
				end;
			end;
		end;
		
	procedure cargarVector (var v:vecZona);
		var
			z:tipoZona; r:infoProp; ok:boolean;
		begin
			ok:=true;
			leerProp(r,z,ok);
			while (ok) do begin
				insertarOrdenado(v[z],r);
				leerProp(r,z,ok);
			end;
		end;
	
	procedure iniVector (var v:vecZona);
		var
			i:integer;
		begin
			for i:=1 to 5 do
				v[i]:=nil;
		end;
		
	procedure buscarProps (l:listaProp; t:integer);
		begin
			while (l <> nil) and (l^.dato.tipo<=t) do begin
				if (l^.dato.tipo = t) then
					writeln('codigo: ',l^.dato.cod);
				l:=l^.sig;
			end;
		end;

//Principal

VAR
	v:vecZona; z:tipoZona; t:integer;
BEGIN
	iniVector(v);
	cargarVector(v);
	writeln('Ahora el inciso b.');
	write('Ingrese una zona (del 1 al 5): ');
	readln(z);
	write('Ingrese un tipo de propiedad: ');
	readln(t);
	buscarProps(v[z],t);
END.	
