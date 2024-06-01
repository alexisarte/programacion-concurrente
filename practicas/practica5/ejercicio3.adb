procedure ejercicio3 is

  task central is
    entry senialProceso1(senial : in String);
    entry senialProceso2(senial : in String);
  end central;

  task proceso1;
  task proceso2;

  task body central is
    Timer : Time;
  begin
    accept senialProceso1;
    loop
      select 
        accept senialProceso1;
      or
        accept senialProceso2 do
          Timer.Start; --setear en 3 minutos
          loop
            select
              accept senialProceso2 do
                if Timer.Elapsed > 180 then
                  exit;
                end if;
              end senialProceso2;
            end select;
          end loop;
        end senialProceso2;
      end select;
    end loop;
  end central;

  task body proceso1 is
  begin
    loop
      select
        central.senialProceso1;
      or delay 120.0;
        null;
      end select;
    end loop;
  end proceso1;

  task body proceso2 is
  begin
    loop
      select
        central.senialProceso2;
      or 
        delay(60.0);
      end select;
    end loop;
  end proceso2;

begin
  null;
end ejercicio3;
