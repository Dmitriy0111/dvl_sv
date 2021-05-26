/*
*  File            : dvl_gen.sv
*  Autor           : Vlasov D.V.
*  Data            : 26.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl monitor class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_GEN__SV
`define DVL_GEN__SV

class dvl_gen #(type item_type, resp_type = item_type) extends dvl_bc;

    const static string type_name = "dvl_gen";

    dvl_sock    #(item_type)    item_sock;
    dvl_sock    #(resp_type)    resp_sock;

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_gen

function dvl_gen::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_GEN__SV
