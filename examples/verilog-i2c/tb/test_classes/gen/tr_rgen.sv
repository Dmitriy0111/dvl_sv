/*
*  File            : tr_rgen.sv
*  Autor           : Vlasov D.V.
*  Data            : 17.12.2020
*  Language        : SystemVerilog
*  Description     : This is transaction random generator 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef TR_RGEN__SV
`define TR_RGEN__SV

class tr_rgen extends tr_gen;
    `OBJ_BEGIN( tr_rgen )

    string                  msg = "Hello World!";

    bit         [31 : 0]    addr;
    bit         [31 : 0]    data;

    int                     rep_c = 20;

    ctrl_trans              resp_item;

    extern function new(string name = "", dvl_bc parent = null);

    extern task build();
    extern task run();
    
endclass : tr_rgen

function tr_rgen::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
    i2c_agt_aep = new();
endfunction : new

task tr_rgen::build();
    item = new("gen_item",this);
    resp_item = new("gen_resp_item",this);

    item_sock = new();
    resp_sock = new();

    if( !dvl_res_db#(virtual clk_rst_if)::get_res_db("cr_if_0",vif) )
        $fatal();
endtask : build

task tr_rgen::run();
    raise();
    begin
        @(posedge vif.rst);
    end
    drop();
endtask : run

`endif // TR_RGEN__SV
