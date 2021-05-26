/*
*  File            : dvl_env.sv
*  Autor           : Vlasov D.V.
*  Data            : 09.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl enviroment class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_ENV__SV
`define DVL_ENV__SV

class dvl_env extends dvl_bc;

    const static string type_name = "dvl_env";

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_env

function dvl_env::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_ENV__SV
