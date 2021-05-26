/*
*  File            : dvl_item.sv
*  Autor           : Vlasov D.V.
*  Data            : 28.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl item class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_ITEM__SV
`define DVL_ITEM__SV

class dvl_item extends dvl_bo;

    const static string type_name = "dvl_item";

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_item

function dvl_item::new(string name = "", dvl_bc parent = null);
    this.parent = parent;
    this.name = name;
    this.fname = { parent.fname , "." , name };
    level = parent.level + 1;
endfunction : new

`endif // DVL_ITEM__SV
