/*
*  File            : dvl_drv.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl driver class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_DRV__SV
`define DVL_DRV__SV

class dvl_drv #(type item_type = int, resp_type = item_type) extends dvl_bc;

    const static string type_name = "dvl_drv";

    dvl_sock    #(item_type)    item_sock;
    dvl_sock    #(resp_type)    resp_sock;

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_drv

function dvl_drv::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_DRV__SV
