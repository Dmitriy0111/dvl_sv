/*
*  File            : dvl_scb.sv
*  Autor           : Vlasov D.V.
*  Data            : 17.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl scoreboard class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_SCB__SV
`define DVL_SCB__SV

class dvl_scb extends dvl_bc;

    const static string type_name = "dvl_scb";

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_scb

function dvl_scb::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_SCB__SV
