/*
*  File            :   dvv_mon.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv monitor class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_MON__SV
`define DVV_MON__SV

class dvv_mon #(type seq_type) extends dvv_bc;

    dvv_sock    #(seq_type)     item_sock;

    extern function new(string name = "", dvv_bc parent = null);

    extern virtual task build();
    extern virtual task run();
    
endclass : dvv_mon

function dvv_mon::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvv_mon::build();
endtask : build

task dvv_mon::run();
endtask : run

`endif // DVV_MON__SV
