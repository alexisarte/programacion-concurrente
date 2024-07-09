procedure GarbageCollector is

  task type camion is
    entry recolectar(idPersona : integer);
  end camion;

  task type persona is
    entry identificar(pos : in integer);
    entry recibirCamion;
  end persona;

  task empresa is 
    entry reclamo(idPersona : in integer);
    entry informarDisponibilidad(idCamion : in integer);
  end empresa;

  camiones: array(1..3) of camion;
  personas: array(1..P) of persona;

  task body empresa is
    idCamion, idPersona : integer;
    reclamos : array(1..P) of integer;
    cantPersonas : integer;
  begin
    loop
      select
        accept reclamo(idPersona : in integer) do
          idPersona := idPersona;
        end reclamo;

        reclamos(idPersona) := reclamos(idPersona) + 1;
        cantPersonas := cantPersonas + 1;
      
      or when cantPersonas > 0 =>
        
        accept informarDisponibilidad(idC : in integer) do
          idCamion := idC;
        end informarDisponibilidad;
        
        idPersona := maxReclamos(reclamos);
        camiones(idCamion).recolectar(idPersona);
        reclamos(idPersona) := reclamos(idPersona) - 1;
      
      end select;
    end loop;    
  end empresa;

  task body persona is
    id: integer;
    llegaCamion : boolean;
  begin
    accept identificar(pos : in integer) do
      id := pos;
    end identificar;

    while (not llegacamion) loop
      empresa.reclamo(id);
      select
        accept recibirCamion;
        llegaCamion := true;
      or delay 900.0;
        null;
      end select;
    end loop;
  end persona;

  task body camion is
    id: integer;
    idPersona : integer;
  begin
    loop
      empresa.informarDisponibilidad(id);
      accept recolectar(idPersona : in integer) do
        idPersona := idPersona;
      end recolectar;
      personas(idPersona).recibirCamion;
    end loop;
  end camion;

begin
  for i in 1..P loop
    personas(i).identificar(i);
  end loop;
end GarbageCollector;
