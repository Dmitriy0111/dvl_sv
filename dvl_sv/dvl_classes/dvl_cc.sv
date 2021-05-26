/*
*  File            : dvl_cc.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl creator class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_CC__SV
`define DVL_CC__SV

typedef class dvl_bc;

class dvl_cc #(type class_t) extends dvl_bo;

    const static string type_name = "dvl_cc";

    typedef dvl_cc #(class_t) this_type;

    static this_type me = get();

    static function class_t create_obj(string name, dvl_bc parent);
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
    
endclass : dvl_cc

`endif // DVL_CC__SV
