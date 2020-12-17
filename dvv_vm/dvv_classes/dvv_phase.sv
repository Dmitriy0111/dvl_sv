/*
*  File            :   dvv_phase.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.20
*  Language        :   SystemVerilog
*  Description     :   This is dvv phase class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_PHASE__SV
`define DVV_PHASE__SV

class dvv_phase extends dvv_bc;

    const static string type_name = "dvv_phase";

    extern function new(string name = "", dvv_bc parent = null);

    extern virtual task exec();
    
endclass : dvv_phase

function dvv_phase::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvv_phase::exec();
endtask : exec

`endif // DVV_PHASE__SV
