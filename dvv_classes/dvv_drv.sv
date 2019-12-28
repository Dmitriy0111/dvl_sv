/*
*  File            :   dvv_drv.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv driver class
*  Copyright(c)    :   2019 Vlasov D.V.
*/

`ifndef DVV_DRV__SV
`define DVV_DRV__SV

class dvv_drv #(type seq_type) extends dvv_bc;

    dvv_sock    #(seq_type)     item_sock;

    extern         function new(string name = "", dvv_bc parent = null);
    extern virtual task     build();
    extern virtual task     run();
    
endclass : dvv_drv

function dvv_drv::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvv_drv::build();
endtask : build
task dvv_drv::run();
endtask : run

`endif // DVV_DRV__SV
