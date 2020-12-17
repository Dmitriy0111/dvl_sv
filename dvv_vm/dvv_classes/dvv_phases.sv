/*
*  File            :   dvv_phases.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.20
*  Language        :   SystemVerilog
*  Description     :   This is dvv phase class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_PHASES__SV
`define DVV_PHASES__SV

// Build phase
class dvv_build_phase extends dvv_phase;
    
    const static string type_name = "dvv_build_phase";

    local static dvv_build_phase inst;
    
    extern function new(string name = "", dvv_bc parent = null);
    
    extern static function dvv_build_phase create(string name = "", dvv_bc parent = null);
    
    extern task exec();

endclass : dvv_build_phase

function dvv_build_phase::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvv_build_phase dvv_build_phase::create(string name = "", dvv_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvv_build_phase::exec();
    print("Build phase start\n");
    test.build();
    test.test_comps = test.child_l;
    foreach(test.test_comps[i])
    begin
        test.test_comps[i].build();
        foreach(test.test_comps[i].child_l[j])
            test.test_comps.push_back(test.test_comps[i].child_l[j]);
    end
    print("Build phase complete\n");
    print("Testbench map:\n");
    test.print_map();
endtask : exec

// Connect phase
class dvv_connect_phase extends dvv_phase;

    const static string type_name = "dvv_connect_phase";
    
    local static dvv_connect_phase inst;

    extern function new(string name = "", dvv_bc parent = null);
    
    extern static function dvv_connect_phase create(string name = "", dvv_bc parent = null);
    
    extern task exec();

endclass : dvv_connect_phase

function dvv_connect_phase::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvv_connect_phase dvv_connect_phase::create(string name = "", dvv_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvv_connect_phase::exec();
    print("Connect phase start\n");
    test.connect();
    foreach(test.test_comps[i])
        test.test_comps[i].connect();
    print("Connect phase complete\n");
endtask : exec

// Run phase
class dvv_run_phase extends dvv_phase;

    const static string type_name = "dvv_run_phase";

    local static dvv_run_phase inst;

    extern function new(string name = "", dvv_bc parent = null);

    extern static function dvv_run_phase create(string name = "", dvv_bc parent = null);
    
    extern task exec();

endclass : dvv_run_phase

function dvv_run_phase::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvv_run_phase dvv_run_phase::create(string name = "", dvv_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvv_run_phase::exec();
    print("Run phase start\n");
    foreach(test.test_comps[i])
    fork
        automatic int index = i;
        test.test_comps[index].run();
    join_none
    #0;
    print("Run phase complete\n");
endtask : exec

// Clean up phase
class dvv_clean_up_phase extends dvv_phase;

    const static string type_name = "dvv_clean_up_phase";

    local static dvv_clean_up_phase inst;

    extern function new(string name = "", dvv_bc parent = null);

    extern static function dvv_clean_up_phase create(string name = "", dvv_bc parent = null);
    
    extern task exec();

endclass : dvv_clean_up_phase

function dvv_clean_up_phase::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvv_clean_up_phase dvv_clean_up_phase::create(string name = "", dvv_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvv_clean_up_phase::exec();
    wait(run_drop == 0);
    print("Clean up phase start\n");
    foreach(test.test_comps[i])
        test.test_comps[i].clean_up();
    print("Clean up phase complete\n");
endtask : exec

// Report phase
class dvv_report_phase extends dvv_phase;

    const static string type_name = "dvv_report_phase";

    local static dvv_report_phase inst;

    extern function new(string name = "", dvv_bc parent = null);

    extern static function dvv_report_phase create(string name = "", dvv_bc parent = null);
    
    extern task exec();

endclass : dvv_report_phase

function dvv_report_phase::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvv_report_phase dvv_report_phase::create(string name = "", dvv_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvv_report_phase::exec();
    print("Test complete!\n");
    $finish;
endtask : exec

`endif // DVV_PHASES__SV
