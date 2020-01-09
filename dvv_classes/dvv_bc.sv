/*
*  File            :   dvv_bc.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv base class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_BC__SV
`define DVV_BC__SV

class dvv_bc;

    string  name;
    string  fname;

    dvv_bc  parent;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_bc

function dvv_bc::new(string name = "", dvv_bc parent = null);
    this.name = name;
    this.parent = parent;
    this.fname = name;
endfunction : new

`endif // DVV_BC__SV
