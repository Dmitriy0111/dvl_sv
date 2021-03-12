/*
*  File            : wb_agt.sv
*  Autor           : Vlasov D.V.
*  Data            : 26.11.2020
*  Language        : SystemVerilog
*  Description     : This is wishbone interface agent 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef WB_AGT__SV
`define WB_AGT__SV

class wb_agt extends dvv_agt;
    `OBJ_BEGIN( wb_agt )

    wb_drv   drv;
    wb_mon   mon;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    
endclass : wb_agt

function wb_agt::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task wb_agt::build();
    drv = wb_drv::create::create_obj("wb_drv", this);
    mon = wb_mon::create::create_obj("wb_mon", this);
endtask : build

`endif // WB_AGT__SV
