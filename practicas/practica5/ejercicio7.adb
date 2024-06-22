procedure Ejercicio7 is

  task type servidor is
    entry identificar(id: in integer);
    entry evaluar(test: in string; codigo, valor: out integer);
  end servidor;

  task especialista;

  servidores: array(1..8) of servidor;

  task body servidor is
    test: string;
    codigo, valor: integer;
  begin
    accept identificar(miId: in integer) do
      id := id;
    end identificar;

    loop 
      accept evaluar(test: in string; cod, v: out integer) do
        Buscar(test, codigo, valor);
        cod := codigo;
        v := valor;
      end evaluar;
    end loop;

  end servidor;

  task body especialista is
    test: string;
    respuesta, codigo, valor, codMasSimilar: integer;
    type resultado is record
      codigo: integer;
      valor: integer;
    end record;
    resultados: array(1..8) of resultado;
  begin
    loop
      test := tomarImagen();
      for i in 1..8 loop
        servidores(i).evaluar(test, codigo, valor); -- me dice que aproveche la bidireccionalidad o que no haya demora innecesaria?
        resultados(i).codigo := codigo;
        resultados(i).valor := valor;
      end loop;
      codMasSimilar := calcularMasSimilar(resultados);
    end loop;
  end especialista;

begin
  for i in 1..8 loop
    servidores(i).identificar(i);
  end loop;
end;