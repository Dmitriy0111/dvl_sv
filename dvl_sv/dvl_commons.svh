/*
*  File            : dvl_commons.svh
*  Autor           : Vlasov D.V.
*  Data            : 15.12.2020
*  Language        : SystemVerilog
*  Description     : This is dvl sv package
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_COMMONS__SVH
`define DVL_COMMONS__SVH

task run_test (string test_name="");
    dvl_root root;

    root = new();
    
    root.run_test(test_name);
endtask

`endif // DVL_COMMONS__SVH
