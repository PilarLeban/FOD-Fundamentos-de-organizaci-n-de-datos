{Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados creado en el
ejercicio 1, informe por pantalla la cantidad de números menores a 15000 y el promedio de los
números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario
una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla. Resolver
el ejercicio realizando un único recorrido del archivo.}

program ejericicio2;
const
	numero_auxiliar = 15000;
type
	archivo_numeros_enteros = file of integer;
var
	numeros_enteros: archivo_numeros_enteros;
	nombre_fisico: string;
	numero, cantidad_menores_qm, suma_total: integer;
	promedio: real;
begin
	writeln('Ingrese el nombre físico del archivo de carga: ');
	readln(nombre_fisico);
	assign(numeros_enteros, nombre_fisico);
	reset(numeros_enteros);
	cantidad_menores_qm := 0;
	suma_total := 0;
	writeln('El listado es el siguiente:');
	while (not eof(numeros_enteros)) do begin	
		read(numeros_enteros, numero);
		writeln(numero);
		if (numero_auxiliar > numero) then
			cantidad_menores_qm := cantidad_menores_qm + 1;
		suma_total := suma_total + numero;
	end;
	promedio := suma_total/fileSize(numeros_enteros);
	writeln('La cantidad de numeros menores a 15000 es: ', cantidad_menores_qm, ' números.');
	writeln('El promedio de los números ingresados es de: ', promedio:0:2);
	close(numeros_enteros); // SIEMPRE CIERRO EL ARCHIVO QUE ABRO.
end.
