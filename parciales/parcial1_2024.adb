--  3. Resolver con ADA el siguiente problema. Para un experimento se tiene una red con 150 controladores de temperatura y un módulo central. Cada controlador toma la temperatura cada 30 segundos y si está fuera de rango realiza lo siguiente: si está por encima del rango espera a que la central que le indique que acción realizar; si está por debajo del rango espera a lo sumo 10 minutos a que la central le indique que acción realizar; en cualquiera de los dos casos, realiza la acción indicada por la central (si fue atendido). La central atiende los pedidos de los controladores dando prioridad a aquellos que son por superar el rango permitido. Nota: suponga que existen las funciones medir() que retorna la temperatura al controlador; actualizar() que simula que el controlador está haciendo la acción indicada por la central; determinar() que es usado por la central para determinar qué acción debe hacer el controlador en base a la información que le envió; el experimento nunca finaliza.

procedure parcial12024 is

  task type controlador;

  task central is
    entry atenderSuperior(temp: in integer; accion: out integer);
    entry atenderInferior(temp: in integer; accion: out integer);
  end central;

  controladores: array(1..150) of controlador;

  task body controlador is
    max, min, temp: integer; -- rango permitido
    accion: string;
  begin
    loop
      delay(30.0);
      temp := medir();
      if (temp > max) then
        central.atenderSuperior(temp, accion);
        actualizar(accion);
      elsif (temp < min) then
        select
          central.atenderInferior(temp, accion);
          actualizar(accion);
        or delay 600.0;
          null;
        end select;
      end if;

    end loop;
  end controlador;

  task body central is
  begin
    loop
      select
        accept atenderSuperior(temp: in integer; accion: out integer) do
          accion:= determinar(temp);
        end atenderSuperior;
      or when (atenderSuperior'count = 0) =>
        accept atenderInferior(temp: in integer; accion: out integer) do
          accion:= determinar(temp);
        end atenderInferior;
      end select;
    end loop;
  end central;

begin
  null;
end;