/*
*  File            :   dvv_res.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv resource
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_RES__SV
`define DVV_RES__SV

class dvv_res #(type res_t);

    res_t       res_val;
    string      res_name;

    extern function new(res_t res_val = null, string res_name = "");
    
endclass : dvv_res

function dvv_res::new(res_t res_val = null, string res_name = "");
    if( res_val == null )
        $fatal("RESOURCE VALUE == NULL");
    this.res_val = res_val;
    this.res_name = res_name;
endfunction : new

`endif // DVV_RES__SV
