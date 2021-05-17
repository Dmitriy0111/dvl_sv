/*
*  File            : dvv_ap.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvv analysis port class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_AP__SV
`define DVV_AP__SV

class dvv_ap #(type item_type, type scr_type) extends dvv_bp #(item_type);

    const static string type_name = "dvv_ap";

    scr_type        scr;

    extern function new(scr_type scr = null, string p_name = "");

    extern function void write(ref item_type item);
    
endclass : dvv_ap

function dvv_ap::new(scr_type scr = null, string p_name = "");
    this.scr = scr;
    this.p_name = p_name != "" ? p_name : "unnamed_ap";
endfunction : new

function void dvv_ap::write(ref item_type item);
    this.scr.write(item);
endfunction : write

`endif // DVV_AP__SV
