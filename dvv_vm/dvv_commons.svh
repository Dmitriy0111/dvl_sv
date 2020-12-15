/*
*  File            :   dvv_commons.svh
*  Autor           :   Vlasov D.V.
*  Data            :   2020.12.15
*  Language        :   SystemVerilog
*  Description     :   This is dvv vm package
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_COMMONS__SVH
`define DVV_COMMONS__SVH

task run_test (string test_name="");
    dvv_root root;

    root = new();
    
    root.run_test(test_name);
endtask

`endif // DVV_COMMONS__SVH
