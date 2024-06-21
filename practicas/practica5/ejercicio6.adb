procedure Money is

  task type persona is
    entry iniciar;
    entry nroEquipoGanador(nroEquipo: in integer);
  end persona;

  task type equipo is
    entry llegada(nroEquipo: in integer);
    entry contarDinero(cantidad: in integer);
  end equipo;

  task juego is
    entry totalGrupo(nroEquipo: in integer; total: in integer);
  end juego;

  personas: array(1..20) of persona;
  equipos: array(1..5) of equipo;

  task body equipo is
    id: integer;
    total: integer;
    integrantes: array(1..5) of integer;
  begin

    accept identificar(nro: in integer) do
      id := nro;
    end identificar;

    for i in 1..4 loop
      accept llegada(idIntegrante: in integer) do
        integrantes(i) := idIntegrante;
      end llegada;
    end loop;

    for i in 1..4 loop
      personas(integrantes(i)).iniciar;
    end loop;

    for i in 1..4 loop
      accept contarDinero(montoPersona: in integer) do
        total := total + montoPersona;
      end contarDinero;
    end loop;

    juego.totalGrupo(id, total);

  end equipo;

  task body persona is
    id, miEquipo: integer;
    dinero: integer;
    nroEquipoGanador: integer;
  begin
    accept identificar(miId: in integer) do
      id := miId;
    end identificar;

    equipos(miEquipo).llegada(id);

    accept iniciar;

    for i in 1..15 loop
      dinero := dinero + Moneda;
    end loop;
    equipos(miEquipo).contarDinero(dinero);

    accept nroEquipoGanador(nroEquipo: in integer) do
      nroEquipoGanador := nroEquipo;
    end nroEquipoGanador;

  end persona;

  task body juego is
    montosTotalesGrupos: array(1..5) of integer;
  begin
    for i in 1..5 loop
      accept totalGrupo(nroEquipo: in integer; total: in integer) do
        montosTotalesGrupos(nroEquipo) := total;
      end totalGrupo;
    end loop;
      equipoGanador := max(montosTotalesGrupos);
    for i in 1..20 loop
      personas(i).nroEquipoGanador(equipoGanador);
    end loop;
  end juego;

begin
  for i in 1..5 loop
    equipos(i).identificar(i);
  end loop;

  for i in 1..20 loop
    personas(i).identificar(i);
  end loop;
end;