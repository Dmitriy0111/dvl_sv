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

    extern function new(string name = "", dvv_bc parent = null);
    
endclass : dvv_test

function dvv_test::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

`endif // DVV_TEST__SV
