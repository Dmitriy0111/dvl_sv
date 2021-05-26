/*
*  File            : dvl_phases.sv
*  Autor           : Vlasov D.V.
*  Data            : 20.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl phase class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_PHASES__SV
`define DVL_PHASES__SV

// Build phase
class dvl_build_phase extends dvl_phase;
    
    const static string type_name = "dvl_build_phase";

    local static dvl_build_phase inst;
    
    extern function new(string name = "", dvl_bc parent = null);
    
    extern static function dvl_build_phase create(string name = "", dvl_bc parent = null);
    
    extern task exec();

endclass : dvl_build_phase

function dvl_build_phase::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvl_build_phase dvl_build_phase::create(string name = "", dvl_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvl_build_phase::exec();
    print("Build phase start\n");

    test.test_comps.push_back(test);
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
class dvl_connect_phase extends dvl_phase;

    const static string type_name = "dvl_connect_phase";
    
    local static dvl_connect_phase inst;

    extern function new(string name = "", dvl_bc parent = null);
    
    extern static function dvl_connect_phase create(string name = "", dvl_bc parent = null);
    
    extern task exec();

endclass : dvl_connect_phase

function dvl_connect_phase::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvl_connect_phase dvl_connect_phase::create(string name = "", dvl_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvl_connect_phase::exec();
    print("Connect phase start\n");
    foreach(test.test_comps[i])
        test.test_comps[i].connect();
    print("Connect phase complete\n");
endtask : exec

// Run phase
class dvl_run_phase extends dvl_phase;

    const static string type_name = "dvl_run_phase";

    local static dvl_run_phase inst;

    extern function new(string name = "", dvl_bc parent = null);

    extern static function dvl_run_phase create(string name = "", dvl_bc parent = null);
    
    extern task exec();

endclass : dvl_run_phase

function dvl_run_phase::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvl_run_phase dvl_run_phase::create(string name = "", dvl_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvl_run_phase::exec();
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
class dvl_clean_up_phase extends dvl_phase;

    const static string type_name = "dvl_clean_up_phase";

    local static dvl_clean_up_phase inst;

    extern function new(string name = "", dvl_bc parent = null);

    extern static function dvl_clean_up_phase create(string name = "", dvl_bc parent = null);
    
    extern task exec();

endclass : dvl_clean_up_phase

function dvl_clean_up_phase::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvl_clean_up_phase dvl_clean_up_phase::create(string name = "", dvl_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvl_clean_up_phase::exec();
    wait(run_drop == 0);
    print("Clean up phase start\n");
    foreach(test.test_comps[i])
        test.test_comps[i].clean_up();
    print("Clean up phase complete\n");
endtask : exec

// Report phase
class dvl_report_phase extends dvl_phase;

    const static string type_name = "dvl_report_phase";

    local static dvl_report_phase inst;

    extern function new(string name = "", dvl_bc parent = null);

    extern static function dvl_report_phase create(string name = "", dvl_bc parent = null);
    
    extern task exec();

endclass : dvl_report_phase

function dvl_report_phase::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

function dvl_report_phase dvl_report_phase::create(string name = "", dvl_bc parent = null);
    if(inst == null)
        inst = new(name, parent);
    return inst; 
endfunction : create

task dvl_report_phase::exec();
    print("Test complete!\n");
    $finish;
endtask : exec

`endif // DVL_PHASES__SV
