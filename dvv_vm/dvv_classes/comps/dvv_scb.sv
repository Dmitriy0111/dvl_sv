/*
*  File            :   dvv_scb.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.17
*  Language        :   SystemVerilog
*  Description     :   This is dvv scoreboard class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_SCB__SV
`define DVV_SCB__SV

class dvv_scb extends dvv_bc;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_scb

function dvv_scb::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_SCB__SV