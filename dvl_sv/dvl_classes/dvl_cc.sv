/*
*  File            : dvv_cc.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvv creator class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_CC__SV
`define DVV_CC__SV

typedef class dvv_bc;

class dvv_cc #(type class_t) extends dvv_bo;

    const static string type_name = "dvv_cc";

    typedef dvv_cc #(class_t) this_type;

    static this_type me = get();

    static function class_t create_obj(string name, dvv_bc parent);
        string msg;
        class_t obj = new(name, parent);
        obj.fname = { parent.fname , "." , name };
        obj.level = parent.level+1;
        $sformat(msg,"Creating %s object\n", obj.fname);
        obj.print(msg);
        return obj;
    endfunction : create_obj

    static function this_type get();
        me = new();
        return me;
    endfunction
    
endclass : dvv_cc

`endif // DVV_CC__SV
