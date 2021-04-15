/*
*  File            : dvv_root.sv
*  Autor           : Vlasov D.V.
*  Data            : 15.12.2020
*  Language        : SystemVerilog
*  Description     : This is dvv root class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_ROOT__SV
`define DVV_ROOT__SV

class dvv_root extends dvv_bc;

    const static string type_name = "dvv_root";

    dvv_domain  domain;
    
    string      test_name;

    extern function new(string name = "", dvv_bc parent = null);

    extern virtual task run_test(string name = "");
    
endclass : dvv_root

function dvv_root::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    domain = new("domain",this);
    fp = $fopen("sim.log","w");
endfunction : new

task dvv_root::run_test(string name = "");
    test_name = name;
    if( test_name != "" )
        test = type_bc[test_name].create_obj(test_name,this);
    else if( $value$plusargs("DVV_TEST=%s", test_name) ) 
        test = type_bc[test_name].create_obj(test_name,this);
    else
        $fatal;

    domain.add_phases();

    domain.exec();

endtask : run_test

`endif // DVV_ROOT__SV
