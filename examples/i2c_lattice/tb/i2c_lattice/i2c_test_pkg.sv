/*
*  File            : i2c_test_pkg.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is package for i2c test
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

package i2c_test_pkg;

    typedef virtual lat_if lat_vif;
    typedef virtual i2c_if i2c_vif;

    import dvv_vm_pkg::*;
    `include "../../../../dvv_vm/dvv_macro.svh"

    `include "../test_classes/ctrl_trans.sv"

    `include "../test_classes/lat/lat_mth.sv"
    `include "../test_classes/lat/lat_drv.sv"
    `include "../test_classes/lat/lat_mon.sv"
    `include "../test_classes/lat/lat_agt.sv"

    `include "../test_classes/gen/tr_gen.sv"
    `include "../test_classes/gen/tr_dgen.sv"

    `include "../test_classes/lat/lat_env.sv"
    
    `include "../test_classes/i2c_mem/i2c_mem.sv"

    `include "../test_classes/tests/i2c_test.sv"

endpackage : i2c_test_pkg
