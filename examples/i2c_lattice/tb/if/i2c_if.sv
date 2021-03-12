/*
*  File            : i2c_if.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is i2c interface
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

interface i2c_if
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     rst
);

    wire    [0 : 0]     scl;
    wire    [0 : 0]     sda;

endinterface : i2c_if
    