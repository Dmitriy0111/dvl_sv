/*
*  File            : dvl_test.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl test class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_TEST__SV
`define DVL_TEST__SV

class dvl_test extends dvl_bc;

    const static string type_name = "dvl_test";

    extern function new(string name = "", dvl_bc parent = null);
    
endclass : dvl_test

function dvl_test::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVL_TEST__SV
