/*
*  File            :   dvv_bc.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv base class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_BC__SV
`define DVV_BC__SV

class dvv_bc extends dvv_bo;

    const static string type_name = "dvv_bc";

    dvv_bc          child_l [$];

    static  dvv_bc  type_bc[string];

    static  dvv_bc  test;
    dvv_bc          test_comps[$];

    extern function new(string name = "", dvv_bc parent = null);

    extern task add_child(dvv_bc child);

    extern virtual task build();
    extern virtual task connect();
    extern virtual task run();
    extern virtual task clean_up();

    extern task print_map();
    extern task print_childs();

    extern virtual function string get_type_name();

    extern virtual function dvv_bc create_obj(string name, dvv_bc parent);
    
endclass : dvv_bc

function dvv_bc::new(string name = "", dvv_bc parent = null);
    this.name = name;
    this.parent = parent;
    this.fname = name;
    level = 0;
    if(parent != null)
        parent.add_child(this);
endfunction : new

task dvv_bc::add_child(dvv_bc child);
    child_l.push_back(child);
endtask : add_child

task dvv_bc::build();
endtask : build

task dvv_bc::connect();
endtask : connect

task dvv_bc::run();
endtask : run

task dvv_bc::clean_up();
endtask : clean_up

task dvv_bc::print_map();
    for(int i = 0 ; i < level ; i++)
        print("    ");
    print( { this.name , "\n" } );
    foreach(child_l[i])
        child_l[i].print_childs();
endtask : print_map

task dvv_bc::print_childs();
    this.print_map();
endtask : print_childs

function string dvv_bc::get_type_name();
    return type_name;
endfunction : get_type_name

function dvv_bc dvv_bc::create_obj(string name, dvv_bc parent);
endfunction : create_obj

`endif // DVV_BC__SV
