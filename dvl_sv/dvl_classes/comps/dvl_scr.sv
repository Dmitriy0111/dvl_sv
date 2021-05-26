/*
*  File            : dvl_scr.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl subscriber class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_SCR__SV
`define DVL_SCR__SV

virtual class dvl_scr #(type item_type = int) extends dvl_bc;

    const static string type_name = "dvl_scr";

    typedef dvl_scr #(item_type) scr_type;

    dvl_ap      #(item_type,scr_type)   item_ap;

    extern function new(string name = "", dvl_bc parent = null);

    pure virtual function void write(ref item_type item);
    
endclass : dvl_scr

function dvl_scr::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_SCR__SV
