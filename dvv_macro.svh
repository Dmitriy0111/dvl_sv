/*
*  File            :   dvv_macro.svh
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.26
*  Language        :   SystemVerilog
*  Description     :   This is dvv macroses
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_MACRO__SV
`define DVV_MACRO__SV

`define OBJ_BEGIN(T) \
    typedef dvv_cc #(T) create;

`endif // DVV_MACRO__SV
