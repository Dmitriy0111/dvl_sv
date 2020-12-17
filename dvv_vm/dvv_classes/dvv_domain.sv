/*
*  File            :   dvv_domain.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.12.15
*  Language        :   SystemVerilog
*  Description     :   This is dvv domain class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_DOMAIN__SV
`define DVV_DOMAIN__SV

class dvv_domain extends dvv_bc;

    const static string type_name = "dvv_domain";

    dvv_phase   phase_q[$];

    extern function new(string name = "", dvv_bc parent = null);

    extern task add_phase(dvv_phase phase);

    extern task add_phases();

    extern task exec();
    
endclass : dvv_domain

function dvv_domain::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvv_domain::add_phase(dvv_phase phase);
    phase_q.push_back(phase);
endtask : add_phase

task dvv_domain::add_phases();
    add_phase( dvv_build_phase   ::create("Build phase"   ) );
    add_phase( dvv_connect_phase ::create("Connect phase" ) );
    add_phase( dvv_run_phase     ::create("Run phase"     ) );
    add_phase( dvv_clean_up_phase::create("Clean up phase") );
    add_phase( dvv_report_phase  ::create("Report phase"  ) );
endtask : add_phases

task dvv_domain::exec();
    dvv_phase c_phase;

    while(phase_q.size())
    begin
        c_phase = phase_q.pop_front();
        c_phase.exec();
    end
endtask : exec

`endif // DVV_DOMAIN__SV
