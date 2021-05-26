/*
*  File            : dvl_bc.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl base class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_BC__SV
`define DVL_BC__SV

class dvl_bc extends dvl_bo;

    const static string type_name = "dvl_bc";

    dvl_bc          child_l [$];

    static  dvl_bc  type_bc[string];

    static  dvl_bc  test;
    dvl_bc          test_comps[$];

    extern function new(string name = "", dvl_bc parent = null);

    extern task add_child(dvl_bc child);

    extern virtual task build();
    extern virtual task connect();
    extern virtual task run();
    extern virtual task clean_up();
    extern virtual task report();

    extern task print_map();
    extern task print_childs();

    extern virtual function string get_type_name();

    extern virtual function dvl_bc create_obj(string name, dvl_bc parent);
    
endclass : dvl_bc

function dvl_bc::new(string name = "", dvl_bc parent = null);
    this.name = name;
    this.parent = parent;
    this.fname = name;
    level = 0;
    if(parent != null)
        parent.add_child(this);
endfunction : new

task dvl_bc::add_child(dvl_bc child);
    child_l.push_back(child);
endtask : add_child

task dvl_bc::build();
endtask : build

task dvl_bc::connect();
endtask : connect

task dvl_bc::run();
endtask : run

task dvl_bc::clean_up();
endtask : clean_up

task dvl_bc::report();
endtask : report

task dvl_bc::print_map();
    for(int i = 0 ; i < level ; i++)
        print("    ");
    print( { this.name , "\n" } );
    foreach(child_l[i])
        child_l[i].print_childs();
endtask : print_map

task dvl_bc::print_childs();
    this.print_map();
endtask : print_childs

function string dvl_bc::get_type_name();
    return type_name;
endfunction : get_type_name

function dvl_bc dvl_bc::create_obj(string name, dvl_bc parent);
endfunction : create_obj

`endif // DVL_BC__SV
