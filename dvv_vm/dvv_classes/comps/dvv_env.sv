/*
*  File            :   dvv_env.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.09
*  Language        :   SystemVerilog
*  Description     :   This is dvv enviroment class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_ENV__SV
`define DVV_ENV__SV

class dvv_env extends dvv_bc;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_env

function dvv_env::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_ENV__SV
