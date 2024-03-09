{1.- Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).}

program p1e1;

//Tipos



const tam = 50;

Type
	rangoDias = 0..31;
	rangoCodigo = 1..15;
	rangoCantidad = 0..99;
	
	infoVenta = record
		cod:rangoCodigo;
		dia:rangoDias;
		cant:rangoCantidad;
	end;
	
	vectorVentas = array [1..tam] of infoVenta;
	
//Procedimientos y Funciones.

{leerVenta genera de manera aleatoria el codigo, lee el dia de la venta y ademas lee la cantidad
* solo si el dia ingresado es diferente de cero porque es la condicion de corte}
procedure leerVenta(var r:infoVenta);
	begin
		r.cod:=random(15)+1;//el 15+1 es porque la funcion random genera de 0 a 14 con el parametro 15, con el "+1" genera de 1 a 15.
		writeln('Ingrese la informacion de producto con codigo', r.cod,': ');
		write('Dia de la venta: ');
		readln(r.dia);
		if (r.dia <> 0) then begin
			write('Cantidad vendida: ');
			readln(r.cant);
		end;
	end;
	
{cargarVentas lee el registro y mientras el dia ingresado sea diferente de 0
* lo va a agregar al vector si la dimension logica no sobre pasa la dimension fisica.
* retorna el vector cargado y la dimension logica del mismo}
procedure cargarVentas(var v:vectorVentas; var dl:integer);
	var
		r:infoVenta; a:integer;
	begin
		dl:=0;
		a:=1;
		leerVenta(r);
		while (dl < tam) and (r.dia <> 0) do begin
			v[a]:=r;
			a:=a+1;
			dl:=dl+1;
			leerVenta(r);
		end;
	end;
	
procedure imprimirVector(v:vectorVentas);
	begin
	end;

//Principal

VAR
	dimLog:integer;
	vector:vectorVentas;
BEGIN
	cargarVentas(vector,dimLog);
END.
