/*
*  File            :   clk_rst_if.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.27
*  Language        :   SystemVerilog
*  Description     :   This is clock and reset interface
*  Copyright(c)    :   2020 Vlasov D.V.
*/

interface clk_rst_if
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     rst
);

endinterface : clk_rst_if
