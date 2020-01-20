/*
*  File            :   dvv_phase.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.01.20
*  Language        :   SystemVerilog
*  Description     :   This is dvv phase class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_PHASE__SV
`define DVV_PHASE__SV

class dvv_phase extends dvv_bc;

    dvv_bc  top_c;

    dvv_bc  all_components [$];

    extern function new(string name = "", dvv_bc parent = null);
    
    extern task build();
    extern task connect();
    extern task run();
    
endclass : dvv_phase

function dvv_phase::new(string name = "", dvv_bc parent = null);
    this.top_c = parent;
endfunction : new

task dvv_phase::build();
    $display("Build phase start");
    top_c.build();
    all_components = top_c.child_l;
    foreach(all_components[i])
    begin
        all_components[i].build();
        foreach(all_components[i].child_l[j])
            all_components.push_back(all_components[i].child_l[j]);
    end
    $display("Build phase complete");
endtask : build

task dvv_phase::connect();
    $display("Connect phase start");
    top_c.connect();
    foreach(all_components[i])
    begin
        all_components[i].connect();
    end
    $display("Connect phase complete");
endtask : connect

task dvv_phase::run();
    $display("Run phase start");
    foreach(all_components[i])
    begin
        $display(all_components[i].fname);
        fork
            all_components[i].run();
        join_any
    end
    $display("Run phase complete");
endtask : run

`endif // DVV_PHASE__SV
