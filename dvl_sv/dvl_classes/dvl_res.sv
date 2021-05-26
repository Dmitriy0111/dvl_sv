/*
*  File            : dvl_res.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl resource
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_RES__SV
`define DVL_RES__SV

class dvl_res #(type res_t);

    const static string type_name = "dvl_res";

    res_t       res_val;
    string      res_name;

    extern function new(string res_name = "", res_t res_val = null);
    
endclass : dvl_res

function dvl_res::new(string res_name = "", res_t res_val = null);
    this.res_val = res_val;
    this.res_name = res_name;
endfunction : new

`endif // DVL_RES__SV
