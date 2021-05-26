/*
*  File            : dvl_sv_pkg.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl sv package
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

package dvl_sv_pkg;
    
    `include "dvl_classes/dvl_bo.sv"
    
    `include "dvl_classes/dvl_cc.sv"

    `include "dvl_classes/dvl_bc.sv"

    `include "dvl_classes/dvl_item.sv"
    
    `include "dvl_classes/dvl_phase.sv"
    `include "dvl_classes/dvl_phases.sv"
    `include "dvl_classes/dvl_domain.sv"
    
    `include "dvl_classes/ports/dvl_bp.sv"
    `include "dvl_classes/ports/dvl_ap.sv"
    `include "dvl_classes/ports/dvl_aep.sv"

    `include "dvl_classes/dvl_res.sv"
    `include "dvl_classes/dvl_res_db.sv"
    
    `include "dvl_classes/dvl_sock.sv"

    `include "dvl_classes/comps/dvl_drv.sv"
    `include "dvl_classes/comps/dvl_mon.sv"
    `include "dvl_classes/comps/dvl_scr.sv"
    `include "dvl_classes/comps/dvl_agt.sv"
    `include "dvl_classes/comps/dvl_env.sv"
    `include "dvl_classes/comps/dvl_scb.sv"
    `include "dvl_classes/comps/dvl_gen.sv"
    `include "dvl_classes/comps/dvl_test.sv"

    `include "dvl_classes/dvl_root.sv"

    `include "dvl_commons.svh"

endpackage : dvl_sv_pkg
