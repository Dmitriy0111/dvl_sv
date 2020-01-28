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

    dvv_bc  top_c;

    extern function new(string name = "", dvv_bc parent = null);
    
    extern task build();
    extern task connect();
    extern task run();
    
endclass : dvv_phase

function dvv_phase::new(string name = "", dvv_bc parent = null);
    this.top_c = parent;
endfunction : new

task dvv_phase::build();
    print("Build phase start\n");
    top_c.build();
    child_l = top_c.child_l;
    foreach(child_l[i])
    begin
        child_l[i].build();
        foreach(child_l[i].child_l[j])
            child_l.push_back(child_l[i].child_l[j]);
    end
    print("Build phase complete\n");
endtask : build

task dvv_phase::connect();
    print("Connect phase start\n");
    top_c.connect();
    foreach(child_l[i])
        child_l[i].connect();
    print("Connect phase complete\n");
endtask : connect

task dvv_phase::run();
    print("Run phase start\n");
    foreach(child_l[i])
    fork
        child_l[i].run_phase.exec();
    join_any
    #100000ns;
    print("Run phase complete\n");
endtask : run

`endif // DVV_PHASE__SV
