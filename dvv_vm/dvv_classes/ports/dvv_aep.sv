/*
*  File            : dvv_aep.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvv analysis export class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_AEP__SV
`define DVV_AEP__SV

class dvv_aep #(type item_type) extends dvv_bp #(item_type);

    const static string type_name = "dvv_aep";

    extern function new(string p_name = "");

    extern function void write(item_type item);

endclass : dvv_aep

function dvv_aep::new(string p_name = "");
    this.p_name = p_name != "" ? p_name : "unnamed_ap";
endfunction : new

function void dvv_aep::write(item_type item);
    foreach(bp_list[i])
        bp_list[i].write(item);
endfunction : write

`endif // DVV_AEP__SV
