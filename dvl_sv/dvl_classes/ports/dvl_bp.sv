/*
*  File            : dvl_bp.sv
*  Autor           : Vlasov D.V.
*  Data            : 10.01.2020
*  Language        : SystemVerilog
*  Description     : This is dvl base port class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_BP__SV
`define DVL_BP__SV

virtual class dvl_bp #(type item_type = int);

    const static string type_name = "dvl_bp";

    typedef dvl_bp #(item_type) bp_type;

    string          p_name;

    bp_type         bp_list [$];

    extern task connect(bp_type bp_item);

    pure virtual function void write(ref item_type item);

endclass : dvl_bp

task dvl_bp::connect(bp_type bp_item);
    bp_list.push_back(bp_item);
endtask : connect

`endif // DVL_BP__SV
