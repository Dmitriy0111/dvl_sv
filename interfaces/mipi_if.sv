/*
*  File            : mipi_if.sv
*  Autor           : Vlasov D.V.
*  Data            : 11.05.2021
*  Language        : SystemVerilog
*  Description     : This is mipi interface
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

interface mipi_if();

    wire    clk_p;
    wire    clk_n;

    wire    d0_p;
    wire    d0_n;

    wire    d1_p;
    wire    d1_n;

    wire    d2_p;
    wire    d2_n;

    wire    d3_p;
    wire    d3_n;
    
endinterface: mipi_if
