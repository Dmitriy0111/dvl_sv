/*
*  File            :   dvv_test.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv test class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_TEST__SV
`define DVV_TEST__SV

class dvv_test extends dvv_bc;

    dvv_phase   phase;

    extern function new(string name = "", dvv_bc parent = null);

    extern virtual task build();
    extern virtual task connect();
    extern virtual task run();

    extern virtual task test_start();
    
endclass : dvv_test

function dvv_test::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    phase = new("test_phase", this);
endfunction : new

task dvv_test::build();
endtask : build

task dvv_test::connect();
endtask : connect

task dvv_test::run();
endtask : run

task dvv_test::test_start();
    phase.build();
    $display("Testbench map:");
    this.print_map();
    phase.connect();
    phase.run();
endtask : test_start

`endif // DVV_TEST__SV
