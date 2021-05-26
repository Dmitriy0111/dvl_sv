/*
*  File            : dvl_domain.sv
*  Autor           : Vlasov D.V.
*  Data            : 15.12.2020
*  Language        : SystemVerilog
*  Description     : This is dvl domain class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_DOMAIN__SV
`define DVL_DOMAIN__SV

class dvl_domain extends dvl_bc;

    const static string type_name = "dvl_domain";

    dvl_phase   phase_q[$];

    extern function new(string name = "", dvl_bc parent = null);

    extern task add_phase(dvl_phase phase);

    extern task add_phases();

    extern task exec();
    
endclass : dvl_domain

function dvl_domain::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvl_domain::add_phase(dvl_phase phase);
    phase_q.push_back(phase);
endtask : add_phase

task dvl_domain::add_phases();
    add_phase( dvl_build_phase   ::create("Build phase"   ) );
    add_phase( dvl_connect_phase ::create("Connect phase" ) );
    add_phase( dvl_run_phase     ::create("Run phase"     ) );
    add_phase( dvl_clean_up_phase::create("Clean up phase") );
    add_phase( dvl_report_phase  ::create("Report phase"  ) );
endtask : add_phases

task dvl_domain::exec();
    dvl_phase c_phase;

    while(phase_q.size())
    begin
        c_phase = phase_q.pop_front();
        c_phase.exec();
    end
endtask : exec

`endif // DVL_DOMAIN__SV
