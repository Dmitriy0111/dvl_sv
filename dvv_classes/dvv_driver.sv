/*
*  File            :   dvv_driver.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv driver class
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_DRIVER__SV
`define DVV_DRIVER__SV

class dvv_driver #(type seq_type) extends dvv_bc;

    dvv_sock    #(seq_type)     item_sock;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_driver

function dvv_driver::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_DRIVER__SV
