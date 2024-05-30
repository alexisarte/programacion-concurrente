procedure Ejercicio1b is

  task puente is
    entry ingresoAuto;
    entry ingresoCamioneta;
    entry ingresoCamion;
    entry salida (peso : Integer);
  end puente;

  task type auto;
  task type camioneta;
  task type camion;

  autos      : array (1 .. A) of auto;
  camionetas : array (1 .. B) of camioneta;
  camiones   : array (1 .. C) of camion;

  task body auto is
  begin
    puente.ingresoAuto;
    --  cruzando el puente
    puente.salida (1);
  end auto;

  task body camioneta is
  begin
    puente.ingresoCamioneta;
    --  cruzando el puente
    puente.salida (2);
  end camioneta;

  task body camion is
  begin
    puente.ingresoCamion;
    --  cruzando el puente
    puente.salida (3);
  end camion;

  task body puente is
    pesoActual, pesoAuto : Integer := 0;
  begin
    loop
      select when ((ingresoCamion'Count = 0) and (peso + 1 <= 5)) =>
        accept ingresoAuto do
          peso := peso + 1;
        end ingresoAuto;
      or when ((ingresoCamion'Count = 0) and (peso + 2 <= 5)) =>
        accept ingresoCamioneta do
          peso := peso + 2;
        end ingresoCamioneta;
      or when ((ingresoCamion'Count = 0) and (peso + 3 <= 5)) =>
        accept ingresoCamion do
          peso := peso + 3;
        end ingresoCamion;
      or
        accept salida (peso : Integer) do
          pesoAuto := peso;
        end salida;
        pesoActual := pesoActual - peso;
      end select;
    end loop;
  end puente;

begin
  null;
end Ejercicio1b;
