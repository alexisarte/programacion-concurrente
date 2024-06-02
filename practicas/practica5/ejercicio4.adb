procedure Clinica is 

  task medico is 
    entry atencionPaciente;
    entry atencionEnfermera(solicitud: in string);
    entry nota(notita: string);
  end medico;

  
  task type enferemera is 
    entry atencion;
  end enferemera;

  task type paciente;

  enferemeras: array(1..E) of enferemera;
  pacientes: array(1..P) of paciente;

  task body paciente is
    contador: integer := 0;
  begin
    loop 
      select
        contador := contador + 1;
        if contador = 3 then 
          exit;
        end if;
        medico.atencion;
      or delay 300.0;
        delay(600.0);
      end select;
    end loop;
  end paciente;

  task body enferemera is 
    paciente: string;
  begin 
    loop 
      select 
        Medico.atencion;
      else
        Medico.nota("Paciente " & paciente & " necesita atencion");
      end select;
    end loop;
  end enferemera;

  task body medico is 
  begin 
    loop 
      select 
        accept atencionEnfermera(solicitud: in string) do
          result := procesar(solicitud);
        end atencionEnfermera;
      or 
        when (atencionEnfermera'count = 0) => 
          accept atencionPaciente;
      or
        when (atencionPaciente'count = 0) => 
          accept nota(notita: string) do
            procesarNota(notita);
          end nota;
      end select;
    end loop;
  end medico;

begin 
  null;
end Clinica;