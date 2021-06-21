/*
*  File            : lv_fv_data.sv
*  Autor           : Vlasov D.V.
*  Data            : 21.06.2021
*  Language        : SystemVerilog
*  Description     : This is lv fv data interface
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

interface lv_fv_data 
    (
        input logic clk,
        input logic rst
    );

    logic   [7 : 0]     R;
    logic   [7 : 0]     G;
    logic   [7 : 0]     B;

    logic   [0 : 0]     FV;
    logic   [0 : 0]     LV;
    logic   [0 : 0]     DV;

endinterface : lv_fv_data
