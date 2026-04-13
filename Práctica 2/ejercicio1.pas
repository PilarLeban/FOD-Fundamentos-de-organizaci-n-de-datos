{Una empresa posee un archivo que contiene información sobre los ingresos percibidos por diferentes
empleados en concepto de comisión. De cada empleado se conoce: código de empleado, nombre y
monto de la comisión.
La información del archivo se encuentra ordenada por código de empleado, y cada empleado puede
aparecer más de una vez en el archivo de comisiones.
Se solicita realizar un procedimiento que reciba el archivo anteriormente descrito y lo compacte. Como
resultado, deberá generar un nuevo archivo en el cual cada empleado aparezca una única vez, con el
valor total acumulado de sus comisiones.
Nota: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser recorrido una única
vez.}
program ejercicio1;
const
    valorAlto = 9999;
type
    empleado = record
        codigo: integer;
        nombre: string[20];
        montoComision: real;
    end;
    archivoEmpleados = file of empleado;

procedure leer(var archivo: archivoEmpleados; var e: empleado);
begin
    if (not EOF (archivo)) then 
        read(archivo, e);
    else
        e.codigo := valorAlto;
end;

procedure compactarArchivo(var arcDet, arcMae: archivoEmpleados);
var
    regD, regM: empleado;
    codigoActual: integer;
    totalComisiones: real;
begin
    reset(arcDet);
    assign(arcMae, 'maestro_compactado');
    rewrite(arcMae);
    leer(arcDet, regD);
    while (regD.codigo <> valorAlto) do begin
        regM := regD;
        codigoActual := regD.codigo;
        totalComisiones := 0;
        while (codigoActual = regD.codigo) do begin 
            totalComisiones := totalComisiones + regD.montoComision;
            leer(arcDet, regD);
        end;
        regM.montoComision := totalComisiones;
        write(arcMae, regM);
    end;
    close(arcDet);
    close(arcMae);
end;

var
    detalle, maestro: archivoEmpleados;
begin
    assign(detalle, 'comisiones');
    compactarArchivo(detalle, maestro);
end.
