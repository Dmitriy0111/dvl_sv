/*
*  File            : dvv_bp.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvv base port class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_BP__SV
`define DVV_BP__SV

virtual class dvv_bp #(type item_type);

    const static string type_name = "dvv_bp";

    typedef dvv_bp #(item_type) bp_type;

    string          p_name;

    bp_type         bp_list [$];

    extern task connect(bp_type bp_item);

    pure virtual function void write(item_type item);

endclass : dvv_bp

task dvv_bp::connect(bp_type bp_item);
    bp_list.push_back(bp_item);
endtask : connect

`endif // DVV_BP__SV
