/*
*  File            :   dvv_vm_pkg.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv vm package
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

package dvv_vm_pkg;
    
    `include "dvv_classes/dvv_cc.sv"

    `include "dvv_classes/dvv_bc.sv"
    
    `include "dvv_classes/dvv_phase.sv"
    `include "dvv_classes/dvv_run_phase.sv"
    
    `include "dvv_classes/ports/dvv_bp.sv"
    `include "dvv_classes/ports/dvv_ap.sv"
    `include "dvv_classes/ports/dvv_aep.sv"

    `include "dvv_classes/dvv_res.sv"
    `include "dvv_classes/dvv_res_db.sv"
    
    `include "dvv_classes/dvv_sock.sv"

    `include "dvv_classes/comps/dvv_drv.sv"
    `include "dvv_classes/comps/dvv_mon.sv"
    `include "dvv_classes/comps/dvv_scr.sv"
    `include "dvv_classes/comps/dvv_agt.sv"
    `include "dvv_classes/comps/dvv_env.sv"
    `include "dvv_classes/comps/dvv_scb.sv"
    `include "dvv_classes/comps/dvv_gen.sv"
    `include "dvv_classes/comps/dvv_test.sv"

endpackage : dvv_vm_pkg
