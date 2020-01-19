/*
*  File            :   dvv_test.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv driver class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_TEST__SV
`define DVV_TEST__SV

class dvv_test extends dvv_bc;

    extern function new(string name = "", dvv_bc parent = null);

    extern virtual task build();
    extern virtual task connect();
    extern virtual task run();
    
endclass : dvv_test

function dvv_test::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task dvv_test::build();
endtask : build

task dvv_test::connect();
endtask : connect

task dvv_test::run();
endtask : run

`endif // DVV_TEST__SV
