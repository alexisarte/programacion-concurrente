procedure Ejercicio1 is

  task puente is
    entry ingresoAuto;
    entry ingresoCamioneta;
    entry ingresoCamion;
    entry salidaAuto;
    entry salidaCamioneta;
    entry salidaCamion;
  end puente;

  task type auto;
  task type camioneta;
  task type camion;

  autos: array (1..A) of auto;
  camionetas: array (1..B) of camioneta;
  camiones: array (1..C) of camion;

  task body auto is
  begin
    puente.ingresoAuto;
    --  cruzando el puente
    puente.salidaAuto;
  end auto;

  task body camioneta is
  begin
    puente.ingresoCamioneta;
    --  cruzando el puente
    puente.salidaCamioneta;
  end camioneta;

  task body camion is
  begin
    puente.ingresoCamion;
    --  cruzando el puente
    puente.salidaCamion;
  end camion;

  task body puente is
    peso : Integer := 0;
  begin
    loop
      select when (peso + 1 <= 5) =>
        accept ingresoAuto do
          peso := peso + 1;
        end ingresoAuto;
      or when (peso + 2 <= 5) =>
        accept ingresoCamioneta do
          peso := peso + 2;
        end ingresoCamioneta;
      or when (peso + 3 <= 5) =>
        accept ingresoCamion do
          peso := peso + 3;
        end ingresoCamion;
      or
        accept salidaAuto do
          peso := peso - 1;
        end salidaAuto;
      or
        accept salidaCamioneta do
          peso := peso - 2;
        end salidaCamioneta;
      or
        accept salidaCamion do
          peso := peso - 3;
        end salidaCamion;
      end select;
    end loop;
  end puente;

begin
  null;
end Ejercicio1;
