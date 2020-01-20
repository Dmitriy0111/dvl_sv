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

class dvv_bc;

    string  name;
    string  fname;

    dvv_bc  parent;
    dvv_bc  child_l [$];

    extern function new(string name = "", dvv_bc parent = null);

    extern task add_child(dvv_bc child);

    extern virtual task build();
    extern virtual task connect();
    extern virtual task run();
    
endclass : dvv_bc

function dvv_bc::new(string name = "", dvv_bc parent = null);
    this.name = name;
    this.parent = parent;
    this.fname = name;

    if(parent != null)
        this.parent.add_child(this);
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

`endif // DVV_BC__SV
