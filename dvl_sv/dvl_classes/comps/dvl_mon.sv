/*
*  File            : dvl_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl monitor class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_MON__SV
`define DVL_MON__SV

class dvl_mon #(type seq_type) extends dvl_bc;

    const static string type_name = "dvl_mon";

    dvl_sock    #(seq_type)     item_sock;

    dvl_aep     #(seq_type)     item_aep;

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_mon

function dvl_mon::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_MON__SV
