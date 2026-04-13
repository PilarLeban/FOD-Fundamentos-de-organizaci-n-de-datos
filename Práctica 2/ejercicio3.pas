{A partir de información sobre la alfabetización en la Argentina, se desea actualizar un archivo maestro
que contiene los siguientes datos: nombre de la provincia, cantidad de personas alfabetizadas y total de
encuestados.
Para ello, se dispone de dos archivos detalle, provenientes de distintas agencias de censo. Cada uno de
estos archivos contiene: nombre de la provincia, código de localidad, cantidad de personas alfabetizadas
y cantidad de encuestados.
Se solicita desarrollar los módulos necesarios para actualizar el archivo maestro a partir de la
información contenida en ambos archivos detalle.
Nota: Todos los archivos están ordenados por nombre de provincia. En los archivos detalle pueden
existir cero, uno o más registros por cada provincia.}
program ejercicio3;
const   
    valorAlto = 'ZZZ';
type
    infoAlfabetizacion = record
        provincia: string[25];
        cantidadAlfabetizados: integer;
        totalEncuestados: integer;
    end;
    
    infoAgencia = record
        provincia: string[25];
        codigoLocalidad: integer;
        cantidadAlfabetizados: integer;
        totalEncuestados: integer;
    end;
    
    archivoAlfabetizacion = file of infoAlfabetizacion;
    archivoAgencia = file of infoAgencia;



procedure leerInfoAgencia(var arcDet: archivoAgencia; var regD: infoAgencia);
begin
    if (not EOF(arcDet)) then 
        read(arcDet, regD)   
    else    
        regD.provincia := valorAlto;  
end;



procedure minimo(var arcDet1, arcDet2: archivoAgencia; 
                 var regD1, regD2, min: infoAgencia);
begin
    if (regD1.provincia <= regD2.provincia) then begin
        min := regD1;                       
        leerInfoAgencia(arcDet1, regD1);   
    end
    else begin
        min := regD2;                       
        leerInfoAgencia(arcDet2, regD2);     
    end;
end;



procedure actualizarMaestro(var arcDet1, arcDet2: archivoAgencia; 
                            var arcMae: archivoAlfabetizacion);
var 
    regD1, regD2, min: infoAgencia;   
    regM: infoAlfabetizacion;        
    provinciaActual: string[25];      
    totalAlf, totalEnc: integer;      
begin
    reset(arcDet1);   
    reset(arcDet2);  
    reset(arcMae);   

    leerInfoAgencia(arcDet1, regD1);  
    leerInfoAgencia(arcDet2, regD2); 

    minimo(arcDet1, arcDet2, regD1, regD2, min); 

    while (min.provincia <> valorAlto) do begin  
        provinciaActual := min.provincia;
        totalAlf := 0;
        totalEnc := 0;
        
        while (min.provincia = provinciaActual) do begin
            totalAlf := totalAlf + min.cantidadAlfabetizados;  
            totalEnc := totalEnc + min.totalEncuestados;        
            minimo(arcDet1, arcDet2, regD1, regD2, min);
        end;

        read(arcMae, regM);   
        while (regM.provincia <> provinciaActual) do
            read(arcMae, regM);   

        regM.cantidadAlfabetizados := regM.cantidadAlfabetizados + totalAlf;
        regM.totalEncuestados := regM.totalEncuestados + totalEnc;

        seek(arcMae, filepos(arcMae)-1);   
        write(arcMae, regM);             
    end;

    close(arcDet1);
    close(arcDet2);
    close(arcMae);
end;

var
    detalle1, detalle2: archivoAgencia;
    maestro: archivoAlfabetizacion;

begin
    assign(detalle1, 'detalle 1');  
    assign(detalle2, 'detalle 2');   
    assign(maestro, 'maestro');    
    actualizarMaestro(detalle1, detalle2, maestro);
end.
