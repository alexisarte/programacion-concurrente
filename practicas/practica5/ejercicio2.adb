procedure Banco is

  task empleado is
    entry atenderCliente (pago : in Integer; comprobante : out String);
  end empleado;

  task type cliente;

  clientes : array (1 .. 10) of cliente;

  task body cliente is
    comprobante : String;
  begin
    select
      empleado.atenderCliente (100, comprobante);
    or delay 600.0;
      null;
    end select;
  end cliente;

  task body empleado is
  begin
    loop
      accept atenderCliente (pago : in Integer; comprobante : out String) do
        comprobante := "Pago de " & pago & " realizado";
      end atenderCliente;
    end loop;
  end empleado;

begin
  null;
end Banco;
