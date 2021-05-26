/*
*  File            : tr_gen.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is transaction generator 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef TR_GEN__SV
`define TR_GEN__SV

class tr_gen extends dvl_gen #(ctrl_trans);
    `OBJ_BEGIN( tr_gen )

    ctrl_trans                  item;

    dvl_aep #(logic [15 : 0])   i2c_agt_aep;

    virtual lat_if              vif;

    extern function new(string name = "", dvl_bc parent = null);

    extern task build();
    extern task run();
    
endclass : tr_gen

function tr_gen::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

task tr_gen::build();
endtask : build

task tr_gen::run();
endtask : run

`endif // TR_GEN__SV
