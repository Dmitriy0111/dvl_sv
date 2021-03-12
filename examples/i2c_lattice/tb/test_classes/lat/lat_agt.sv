/*
*  File            : lat_agt.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is lattice interface agent 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef LAT_AGT__SV
`define LAT_AGT__SV

class lat_agt extends dvv_agt;
    `OBJ_BEGIN( lat_agt )

    lat_drv     drv;
    lat_mon     mon;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    
endclass : lat_agt

function lat_agt::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task lat_agt::build();
    drv = lat_drv::create::create_obj("lat_drv", this);
    mon = lat_mon::create::create_obj("lat_mon", this);
endtask : build

`endif // LAT_AGT__SV
