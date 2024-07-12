--  2) Resolver con ADA el siguiente problema. La oficina central de una empresa de venta de indumentaria debe calcular
--  cuántas veces fue vendido cada uno de los artículos de su catálogo. La empresa se compone de 100 sucursales y cada
--  una de ellas maneja su propia base de datos de ventas. La oficina central cuenta con una herramienta que funciona de la
--  siguiente manera: ante la consulta realizada para un artículo determinado, la herramienta envía el identificador del
--  artículo a cada una de las sucursales, para que cada uno de éstas calcule cuántas veces fue vendido en ella. Al final del
--  procesamiento, la herramienta debe conocer cuántas veces fue vendido en total, considerando todas las sucursales.
--  Cuando ha terminado de procesar un artículo comienza con el siguiente (suponga que la herramienta tiene una función
--  generarArtículo que retorna el siguiente ID a consultar). Nota: maximizar la concurrencia. Supongo que existe una
--  función ObtenerVentas(ID) que retorna la cantidad de veces que fue vendido el artículo con identificador ID en la base
--  de datos de la sucursal que la llama.

procedure parcial is

  task oficina is 
    entry consultarArticulo;
  end oficina;

  task type sucursal is 
    entry cantVendida(idProducto: in int; cant: out int);
  end sucursal;

  sucursales: array(1..100) of sucursal;

  task body oficina is
    idProducto, cant, total: int;
  begin
    loop
      idProducto := generarArticulo;
      accept consultarArticulo do
        total := 0;
        for i in 1..100 loop
          sucursales(i).cantVendida(idProducto, cant);
          total := total + cant;
        end loop;
      end consultarArticulo;
    end loop;
  end oficina;

  task body sucursal is
    idProducto: int;
  begin
    loop
      accept cantVendida(idProducto: in int; cant: out int) do
        cant := ObtenerVentas(idProducto);
      end cantVendida;
    end loop;
  end sucursal;

begin
  null;
end;