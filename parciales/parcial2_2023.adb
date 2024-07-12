--  2) En un negocio de cobros digitales hay P personas que deben pasar por la única caja de cobros para realizar el pago de
--  sus boletas. Las personas son atendidas de acuerdo con el orden de llegada, teniendo prioridad aquellos que deben
--  pagar menos de 5 boletas de los que pagan más. Adicionalmente, las personas embarazadas y los ancianos tienen
--  prioridad sobre los dos casos anteriores. Las personas entregan sus boletas al cajero y el dinero de pago; el cajero les
--  devuelve el vuelto y los recibos de pago. Implemente un programa que permita resolver el problema anterior usando
--  ADA.

procedure parcial2_2023 is

  task type persona;

  task caja is
    entry pagarEmbAnc(boletas: in string; dinero: in integer; vuelto: out integer; recibos: out string);
    entry pagarMenosDe5(boletas: in string; dinero: in integer; vuelto: out integer; recibos: out string);
    entry pagarGeneral(boletas: in string; dinero: in integer; vuelto: out integer; recibos: out string);
  end caja;

  personas: array(1..P) of persona;

  task body caja is
    boletas, recibos: string;
    dinero, vuelto: integer;
  begin
    for i in 1..P loop
      select
        accept pagarEmbAnc(boletas: in string; dinero: in integer; vuelto: out integer; recibos: out string) do
          procesarPago(boletas, dinero, v, r);
          vuelto := v;
          recibos := r;
        end pagarEmbAnc;
      or when (pagarEmbAnc'count = 0) => 
        accept pagarMenosDe5(boletas: in string; dinero: in integer; vuelto: out integer; recibos: out string) do
          procesarPago(boletas, dinero, v, r);
          vuelto := v;
          recibos := r;
        end pagarMenosDe5;
      or when (pagarEmbAnc'count = 0 and pagarMenosDe5'count = 0) =>
        accept pagarGeneral(boletas: in string; dinero: in integer; vuelto: out integer; recibos: out string) do
          procesarPago(boletas, dinero, v, r);
          vuelto := v;
          recibos := r;
        end pagarGeneral;
      end select;
    end loop;
  end caja;

  task body persona is
    boletas, recibos: string;
    dinero, vuelto: integer;
  begin
    if (soyEmbAnc()) then
      caja.pagarEmbAnc(boletas, dinero, vuelto, recibos);
    elsif (boletas < 5) then
      caja.pagarMenosDe5(boletas, dinero, vuelto, recibos);
    else
      caja.pagarGeneral(boletas, dinero, vuelto, recibos);
    end if;
  end persona;

begin
  null;
end;