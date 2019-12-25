/*
*  File            :   dvv_monitor.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv monitor class
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_MONITOR__SV
`define DVV_MONITOR__SV

class dvv_monitor #(type seq_type) extends dvv_bc;

    dvv_sock    #(seq_type)     item_sock;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_monitor

function dvv_monitor::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_MONITOR__SV
