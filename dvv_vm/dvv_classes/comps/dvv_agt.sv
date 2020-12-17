/*
*  File            :   dvv_agt.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv agent class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_AGT__SV
`define DVV_AGT__SV

class dvv_agt extends dvv_bc;

    const static string type_name = "dvv_agt";

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_agt

function dvv_agt::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_AGT__SV
