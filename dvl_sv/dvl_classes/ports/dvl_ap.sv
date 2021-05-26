/*
*  File            : dvl_ap.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl analysis port class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_AP__SV
`define DVL_AP__SV

class dvl_ap #(type item_type = int, type scr_type) extends dvl_bp #(item_type);

    const static string type_name = "dvl_ap";

    scr_type        scr;

    extern function new(scr_type scr = null, string p_name = "");

    extern function void write(ref item_type item);
    
endclass : dvl_ap

function dvl_ap::new(scr_type scr = null, string p_name = "");
    this.scr = scr;
    this.p_name = p_name != "" ? p_name : "unnamed_ap";
endfunction : new

function void dvl_ap::write(ref item_type item);
    this.scr.write(item);
endfunction : write

`endif // DVL_AP__SV
