/*
*  File            : dvv_scr.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvv subscriber class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_SCR__SV
`define DVV_SCR__SV

virtual class dvv_scr #(type item_type) extends dvv_bc;

    const static string type_name = "dvv_scr";

    typedef dvv_scr #(item_type) scr_type;

    dvv_ap      #(item_type,scr_type)   item_ap;

    extern function new(string name = "", dvv_bc parent = null);

    pure virtual function void write(item_type item);
    
endclass : dvv_scr

function dvv_scr::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_SCR__SV
