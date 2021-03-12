/*
*  File            : dvv_gen.sv
*  Autor           : Vlasov D.V.
*  Data            : 26.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvv monitor class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_GEN__SV
`define DVV_GEN__SV

class dvv_gen #(type item_type, resp_type = item_type) extends dvv_bc;

    const static string type_name = "dvv_gen";

    dvv_sock    #(item_type)    item_sock;
    dvv_sock    #(resp_type)    resp_sock;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_gen

function dvv_gen::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_GEN__SV
