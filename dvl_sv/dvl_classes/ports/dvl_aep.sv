/*
*  File            : dvl_aep.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl analysis export class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_AEP__SV
`define DVL_AEP__SV

class dvl_aep #(type item_type = int) extends dvl_bp #(item_type);

    const static string type_name = "dvl_aep";

    extern function new(string p_name = "");

    extern function void write(ref item_type item);

endclass : dvl_aep

function dvl_aep::new(string p_name = "");
    this.p_name = p_name != "" ? p_name : "unnamed_ap";
endfunction : new

function void dvl_aep::write(ref item_type item);
    foreach(bp_list[i])
        bp_list[i].write(item);
endfunction : write

`endif // DVL_AEP__SV
