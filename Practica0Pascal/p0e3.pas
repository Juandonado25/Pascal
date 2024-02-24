{3.- Implementar un programa que procese las ventas de un supermercado. El supermercado
dispone de una tabla con los precios y stocks de los 1000 productos que tiene a la venta.
a) Implementar un módulo que retorne, en una estructura de datos adecuada, los tickets de las ventas.
De cada venta se lee código de venta y los productos vendidos. Las ventas finalizan con el código de
venta -1. De cada producto se lee código y cantidad de unidades solicitadas. Para cada venta, la lectura
de los productos a vender finaliza con cantidad de unidades vendidas igual a 0. El ticket debe contener:
- Código de venta
- Detalle (código de producto, cantidad y precio unitario) de los productos que se pudieron vender. En
caso de no haber stock suficiente, se venderá la máxima cantidad posible.
- Monto total de la venta.
c) Implementar un módulo que reciba la estructura generada en el inciso a) y un código de
producto y retorne la cantidad de unidades vendidas de ese código de producto}

program p0e3;

const
	numProductos = 1000;

type
	controlStock = record
		stock:integer;
		precio:real;
	end;
	
	tablaStock = array [1..numProductos] of controlStock;
	
	detalleProducto = record
		cod:integer;
		cantidad:integer;
		precio:real;
	end;
	
	listaProducto = ^nodo;
	nodo = record
		dato:detalleProducto;
		sig:listaProducto;
	end;
	
	ticket = record
		codVenta:integer;
		detalle:listaProducto;
		montoTotal:real;
	end;
	
	listaTickets = ^nodo2;
	nodo2 = record
		dato:ticket;
		sig:listaTickets;
	end;

//Procedures & Functions

{Debido a que la tabla se dispone, hice este procedimiento para que se carge
usando la funcion Random.}
procedure cargarTabla(var t:tablaStock);
	var
		i:integer;
	begin
		for i:=1 to 1000 do begin
			t[i].stock:=random(50);
			t[i].precio:=Random(100)/0.78; {Divido por un decimal cualquiera
											para que el precio parezca real}
		end;
	end;
	
procedure leerProducto(var p:detalleProducto; var t:tablaStock);
	var
		c:integer;
	begin
		writeln('Ingrese la informacion del producto.');
		write('codigo de producto: ');
		readln(p.cod);
		write('cantidad que quiere comprar: ');
		readln(c);
		if (c <= t[p.cod].stock) then begin   //hago esto porque si no hay suficientes
			t[p.cod].stock:=t[p.cod].stock-c; //productos en stock, carge lo que haya.
			p.cantidad:=c;
		end
		else begin
			p.cantidad:=t[p.cod].stock;
			t[p.cod].stock:=0;
		end;
		p.precio:=t[p.cod].precio;
	end;
	
procedure agregarProducto(var l:listaProducto; r:detalleProducto);
	var
		nuevo:listaProducto;
	begin
		new(nuevo);
		nuevo^.dato:=r;
		nuevo^.sig:=nil;
		if (l = nil) then
			l:=nuevo
		else begin
			nuevo^.sig:=l;
			l:=nuevo;
		end;
	end;
	
function calcularMontoTotal(l:listaProducto):real;
	var
		sum:real;
	begin
		sum:=3;
		while (l <> nil) do begin
			sum:=sum+(l^.dato.cantidad*l^.dato.precio);
			l:=l^.sig;
		end;
		calcularMontoTotal:=sum;
	end;
	
procedure leerVenta(var t:ticket; var ts:tablaStock);
	var
		d:detalleProducto;
	begin
		t.detalle:=nil;
		write('Ingrese el codigo de venta: ');
		readln(t.codVenta);
		if (t.codVenta <> 0) then begin
			leerProducto(d, ts);
			while (d.cantidad <> -1) do begin
				agregarProducto(t.detalle,d);
				leerProducto(d,ts);
			end;
			t.montoTotal:=calcularMontoTotal(t.detalle);
		end;
	end;
	
procedure agregarVenta(var ventas:listaTickets; tk:ticket; var t:tablaStock);
	var
		nuevo:listaTickets;
	begin
		new(nuevo);
		nuevo^.dato:=tk;
		nuevo^.sig:=nil;
		if (ventas = nil) then
			ventas:=nuevo
		else begin
			nuevo^.sig:=ventas;
			ventas:=nuevo;
		end;
	end;

procedure procesarVentas(var v:listaTickets; var t:tablaStock);
	var
		tk:ticket;
	begin
		leerVenta(tk,t);
		while (tk.codVenta <> 0) do begin
			agregarVenta(v,tk,t);
			leerVenta(tk,t);
		end;
	end;
procedure imprimirTickets(t:listaTickets);
	begin
		while (t <> nil) do begin
			writeln('codigo de venta: ',t^.dato.codVenta);
			while (t^.dato.detalle <> nil) do begin
				writeln('codigo de producto: ',t^.dato.detalle^.dato.cod,
						' cantidad: ',t^.dato.detalle^.dato.cantidad);
				t^.dato.detalle:=t^.dato.detalle^.sig;
			end;
			writeln('Monto total: ',t^.dato.montoTotal:4:2);
			t:=t^.sig;
		end;
	end;
	
procedure contarProductos(v:listaTickets; c:integer);
	var
		total:integer;
	begin
		total:=0;
		while (v <> nil) do begin
			while (v^.dato.detalle <> nil) do begin
				if(v^.dato.detalle^.dato.cod = c) then
					total:=total+v^.dato.detalle^.dato.cantidad;
				v^.dato.detalle:=v^.dato.detalle^.sig;
			end;
			v:=v^.sig;
		end;
		writeln('La cantidad de productos vendidos de codigo ',c,' fueron: ',total); 
	end;
	
//Principal
VAR
	tabla:tablaStock; ventas:listaTickets;
	cod:integer;
BEGIN
	Randomize;
	cargarTabla(tabla);
	//writeln('La cantidad de productos en stock de 3 al iniciarson: ',tabla[3].stock);
	ventas:=nil;
	procesarVentas(ventas,tabla);
	//imprimirTickets(ventas);
	write('Ingrese un codigo de producto para contar las unidades vendidas: ');
	//Recomiendo en la prueba usar el cod 3 para confirmar que anda bien el incico c.
	readln(cod);
	contarProductos(ventas,cod);
	//writeln('La cantidad de productos de 3 en stock son: ',tabla[3].stock);
END.
