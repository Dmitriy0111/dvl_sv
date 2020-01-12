/*
*  File            :   dvv_ap.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.10
*  Language        :   SystemVerilog
*  Description     :   This is dvv analysis port class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_AP__SV
`define DVV_AP__SV

class dvv_ap #(type item_type, type scr_type) extends dvv_bp #(item_type);

    scr_type        scr;

    extern         function new(scr_type scr = null);

    extern virtual function write(item_type item);
    
endclass : dvv_ap

function dvv_ap::new(scr_type scr = null);
    this.scr = scr;
endfunction : new

function dvv_ap::write(item_type item);
    this.scr.write(item);
endfunction : write

`endif // DVV_AP__SV
