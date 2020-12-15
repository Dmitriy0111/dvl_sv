/*
*  File            :   i2c_test_pkg.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.26
*  Language        :   SystemVerilog
*  Description     :   This is package for i2c test
*  Copyright(c)    :   2020 Vlasov D.V.
*/

package i2c_test_pkg;

    typedef virtual wb_if wb_vif;

    import dvv_vm_pkg::*;
    `include "../../../../dvv_vm/dvv_macro.svh"

    `include "../test_classes/ctrl_trans.sv"

    `include "../test_classes/wb/wb_mth.sv"
    `include "../test_classes/wb/wb_drv.sv"
    `include "../test_classes/wb/wb_mon.sv"
    `include "../test_classes/wb/wb_agt.sv"

    `include "../test_classes/gen/tr_gen.sv"
    `include "../test_classes/gen/tr_dgen.sv"

    `include "../test_classes/wb/wb_env.sv"

    `include "../test_classes/tests/i2c_test.sv"

endpackage : i2c_test_pkg
