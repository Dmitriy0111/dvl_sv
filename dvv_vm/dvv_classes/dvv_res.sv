/*
*  File            : dvv_res.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvv resource
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_RES__SV
`define DVV_RES__SV

class dvv_res #(type res_t);

    const static string type_name = "dvv_res";

    res_t       res_val;
    string      res_name;

    extern function new(string res_name = "", res_t res_val = null);
    
endclass : dvv_res

function dvv_res::new(string res_name = "", res_t res_val = null);
    this.res_val = res_val;
    this.res_name = res_name;
endfunction : new

`endif // DVV_RES__SV
