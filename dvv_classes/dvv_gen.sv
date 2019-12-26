/*
*  File            :   dvv_gen.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.26
*  Language        :   SystemVerilog
*  Description     :   This is dvv monitor class
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_GEN__SV
`define DVV_GEN__SV

class dvv_gen #(type seq_type) extends dvv_bc;

    dvv_sock    #(seq_type)     item_sock;

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_gen

function dvv_gen::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_GEN__SV
