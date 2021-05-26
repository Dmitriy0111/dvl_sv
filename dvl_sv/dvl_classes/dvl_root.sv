/*
*  File            : dvl_root.sv
*  Autor           : Vlasov D.V.
*  Data            : 15.12.2020
*  Language        : SystemVerilog
*  Description     : This is dvl root class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_ROOT__SV
`define DVL_ROOT__SV

class dvl_root extends dvl_bc;

    const static string type_name = "dvl_root";

    dvl_domain  domain;
    
    string      test_name;

    extern function new(string name = "", dvl_bc parent = null);

    extern virtual task run_test(string name = "");
    
endclass : dvl_root

function dvl_root::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
    domain = new("domain",this);
    fp = $fopen("sim.log","w");
endfunction : new

task dvl_root::run_test(string name = "");
    test_name = name;
    if( test_name != "" )
        test = type_bc[test_name].create_obj(test_name,this);
    else if( $value$plusargs("dvl_TEST_NAME=%s", test_name) ) 
        test = type_bc[test_name].create_obj(test_name,this);
    else
        $fatal;

    domain.add_phases();

    domain.exec();

endtask : run_test

`endif // DVL_ROOT__SV
