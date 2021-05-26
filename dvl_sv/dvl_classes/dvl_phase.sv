/*
*  File            : dvl_phase.sv
*  Autor           : Vlasov D.V.
*  Data            : 20.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl phase class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_PHASE__SV
`define DVL_PHASE__SV

class dvl_phase extends dvl_bc;

    const static string type_name = "dvl_phase";

    extern function new(string name = "", dvl_bc parent = null);

    extern virtual task exec();
    
endclass : dvl_phase

function dvl_phase::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvl_phase::exec();
endtask : exec

`endif // DVL_PHASE__SV
