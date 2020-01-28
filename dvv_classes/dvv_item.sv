/*
*  File            :   dvv_item.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.28
*  Language        :   SystemVerilog
*  Description     :   This is dvv item class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_ITEM__SV
`define DVV_ITEM__SV

class dvv_item extends dvv_bo;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_item

function dvv_item::new(string name = "", dvv_bc parent = null);
    this.parent = parent;
    this.name = name;
    this.fname = { parent.fname , "." , name };
    level = parent.level + 1;
endfunction : new

`endif // DVV_ITEM__SV
