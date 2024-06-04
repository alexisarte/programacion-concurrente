procedure Ejercicio5 is 

  task servidor is 
    entry pedidos (id: in integer);
  end servidor;

  task type usuario is 
    entry respuesta (res: in String);
  end usuario;
  
  usuarios: array(1..10) of usuario;

  task body servidor is
    ok: Boolean;
  begin
    loop
      select
        accept pedidos (p: in String; ok: out String) do
          ok := procesarPedido(p);
        end pedidos;
      end select;
    end loop;
  end servidor;

  task body usuario is
    documento: String;
    ok: Boolean;
  begin
    documento := trabajarDocumento;
    while not ok loop
      select
        servidor.pedidos(documento, ok);
        if not ok then
          documento := corregir(documento);
        end if;
      or delay 120.0;
        delay (60.0);
      end select;
    end loop;
  end usuario;
  
begin
  null;
end Ejercicio5;