program ejercicio9;
const
	valorAlto = 9999;
type
	cliente = record
		codigo: integer;
		nombre: string[20];
		apellido: string[20];
	end;
	
	date = record
		año: integer;
		mes: integer;
		dia: integer;
	end;
	
	venta = record
		cli: cliente;
		fecha: date;
		monto: real;
	end;
	
	archivo = file of venta;

// procedimientos
procedure asignarArchivo(var arc: archivo);
var
	nombre: string[20];
begin
	writeln('Ingrese el nombre del archivo: ');
	readln(nombre);
	assign(arc, nombre);
end;

procedure leerArchivo(var arc: archivo; var v: venta);
begin
	if (not EOF (arc)) then 
		read(arc, v)
	else
		v.cli.codigo := valorAlto;
end;

procedure recorrerArchivoYReporte(var arc: archivo);
var
	codigoActual, añoActual, mesActual: integer;
	totalMes, totalAño, totalEmpresa: real;
	v: venta;
begin
	asignarArchivo(arc);
	reset(arc);
	leerArchivo(arc, v);
	totalEmpresa := 0;
	
	while (v.cli.codigo <> valorAlto) do begin 
		codigoActual := v.cli.codigo;
		writeln('Informe del cliente con código: ', codigoActual, ' - : ',
		v.cli.nombre, ' ', v.cli.apellido);
		
		while (codigoActual = v.cli.codigo) do begin 
			añoActual := v.fecha.año;
			totalAño := 0;
			writeln('    Año: ', añoActual);
			
			while (codigoActual = v.cli.codigo) and (añoActual = v.fecha.año) do begin
				mesActual := v.fecha.mes;
				totalMes := 0;
				
				while (codigoActual = v.cli.codigo) and (añoActual = v.fecha.año) and (mesActual = v.fecha.mes) do begin 
					totalMes := totalMes + v.monto;
					leerArchivo(arc, v);
				end;
				
				writeln('    Mes: ', mesActual, ': $', totalMes:0:2);
				totalAño := totalAño + totalMes;
			end;
			writeln('    Total del año: ', totalAño:0:2);
			totalEmpresa := totalEmpresa + totalAño;
		end;
	end;
	
	writeln('El monto total de ventas obtenido por la empresa es: ', totalEmpresa:0:2);
	close(arc);
end;

// programa principal
var
	arc: archivo;
begin
	recorrerArchivoYReporte(arc);
end.
