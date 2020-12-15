/*
*  File            :   wb_if.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.26
*  Language        :   SystemVerilog
*  Description     :   This is wishbone interface
*  Copyright(c)    :   2020 Vlasov D.V.
*/

interface wb_if
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     rst
);

    logic   [2 : 0]     wbs_adr_i;
    logic   [7 : 0]     wbs_dat_i;
    logic   [7 : 0]     wbs_dat_o;
    logic   [0 : 0]     wbs_we_i;
    logic   [0 : 0]     wbs_stb_i;
    logic   [0 : 0]     wbs_ack_o;
    logic   [0 : 0]     wbs_cyc_i;

endinterface : wb_if
