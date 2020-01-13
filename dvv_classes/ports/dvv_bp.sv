/*
*  File            :   dvv_bp.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.10
*  Language        :   SystemVerilog
*  Description     :   This is dvv base port class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_BP__SV
`define DVV_BP__SV

virtual class dvv_bp #(type item_type);

    typedef dvv_bp #(item_type) bp_type;

    bp_type         bp_list [$];

    extern       task     connect(bp_type bp_item);

    pure virtual function write(item_type item);

endclass : dvv_bp

task dvv_bp::connect(bp_type bp_item);
    bp_list.push_back(bp_item);
endtask : connect

`endif // DVV_BP__SV