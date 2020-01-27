/*
*  File            :   dvv_run_phase.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.27
*  Language        :   SystemVerilog
*  Description     :   This is dvv run phase class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_RUN_PHASE__SV
`define DVV_RUN_PHASE__SV

class dvv_run_phase;

    dvv_bc  parent;

    extern function new(string name = "", dvv_bc parent = null);
    
    extern task exec();
    
endclass : dvv_run_phase

function dvv_run_phase::new(string name = "", dvv_bc parent = null);
    this.parent = parent;
    $display(parent.fname);
endfunction : new

task dvv_run_phase::exec();
    $display("Call parent run task", parent.fname);
    parent.run();
endtask : exec

`endif // DVV_RUN_PHASE__SV
