/*
*  File            :   dvv_cc.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv creator class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_CC__SV
`define DVV_CC__SV

typedef class dvv_bc;

class dvv_cc #(type class_t);

    static function class_t create_obj(string name, dvv_bc parent);
        class_t obj = new(name, parent);
        obj.fname = { parent.fname , "." , name };
        $display("Creating %s object", obj.fname);
        return obj;
    endfunction : create_obj
    
endclass : dvv_cc

`endif // DVV_CC__SV
