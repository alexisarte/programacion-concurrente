procedure BCRA is

  task BCRA_Task;

  task type API is
    entry consultarCotizacion(id: out integer; dolar: out float);
  end API;

  apis: array(1..20) of API;

  task body BCRA_Task is
    cotizacion: float;
    id: integer;
  begin
    loop
      for i in 1..20 loop
        select
          apis(i).cotizacion(id, cotizacion);
          put_line("ID y Cotizacion del dolar: " & id & " " & cotizacion);
        or delay 5.0;
          put_line("ID y Cotizacion del dolar: ");
        end select;
      end loop;
    end loop;
  end BCRA_Task;

  task body API is
    id: integer;
    dolar: float;
  begin
    loop
      accept consultarCotizacion(id: out integer; dolar: out float) do
        id := id;
        dolar := 60.0;
      end consultarCotizacion;
    end loop;
  end API;

begin
  null;
end BCRA;