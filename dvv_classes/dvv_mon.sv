/*
*  File            :   dvv_mon.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv monitor class
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_MON__SV
`define DVV_MON__SV

class dvv_mon #(type seq_type) extends dvv_bc;

    dvv_sock    #(seq_type)     item_sock;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_mon

function dvv_mon::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_MON__SV
