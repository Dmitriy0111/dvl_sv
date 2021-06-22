/*
*  File            : clb_lvds_if.sv
*  Autor           : Vlasov D.V.
*  Data            : 22.06.2021
*  Language        : SystemVerilog
*  Description     : This is camera link base lvds interface
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

interface clb_lvds_if
(
    input   logic   clk,
    input   logic   rst
);

    logic       clk_p;
    logic       clk_n;

    logic       d0_p;
    logic       d0_n;

    logic       d1_p;
    logic       d1_n;

    logic       d2_p;
    logic       d2_n;

    logic       d3_p;
    logic       d3_n;
    
endinterface : clb_lvds_if
