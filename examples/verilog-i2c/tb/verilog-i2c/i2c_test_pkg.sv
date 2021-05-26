/*
*  File            : i2c_test_pkg.sv
*  Autor           : Vlasov D.V.
*  Data            : 26.11.2020
*  Language        : SystemVerilog
*  Description     : This is package for i2c test
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

package i2c_test_pkg;

    typedef virtual wb_if wb_vif;

    import dvl_sv_pkg::*;
    `include "../../../../dvl_sv/dvl_macro.svh"

    `include "../test_classes/ctrl_trans.sv"

    `include "../test_classes/wb/wb_mth.sv"
    `include "../test_classes/wb/wb_drv.sv"
    `include "../test_classes/wb/wb_mon.sv"
    `include "../test_classes/wb/wb_agt.sv"
    `include "../test_classes/wb/wb_cov.sv"

    `include "../test_classes/gen/tr_gen.sv"
    `include "../test_classes/gen/tr_dgen.sv"
    `include "../test_classes/gen/tr_rgen.sv"

    `include "../test_classes/wb/wb_env.sv"

    `include "../../../../models/i2c_mem/i2c_mem.sv"

    `include "../test_classes/tests/i2c_test.sv"

endpackage : i2c_test_pkg
