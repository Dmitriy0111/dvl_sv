/*
*  File            :   dvv_drv.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv driver class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_DRV__SV
`define DVV_DRV__SV

class dvv_drv #(type item_type, resp_type = item_type) extends dvv_bc;

    dvv_sock    #(item_type)    item_sock;
    dvv_sock    #(resp_type)    resp_sock;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_drv

function dvv_drv::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_DRV__SV
