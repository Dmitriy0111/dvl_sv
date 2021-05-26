/*
*  File            : dvl_agt.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl agent class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_AGT__SV
`define DVL_AGT__SV

class dvl_agt extends dvl_bc;

    const static string type_name = "dvl_agt";

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_agt

function dvl_agt::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_AGT__SV
