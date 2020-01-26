/*
*  File            :   dvv_vm_pkg.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.22
*  Language        :   SystemC
*  Description     :   This is dvv vm package
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_VM_PKG__H
#define DVV_VM_PKG__H

    #include <map>

    #include "systemc.h"

    #include "sysc/kernel/sc_module.h"
    #include "sysc/kernel/sc_process_handle.h"
    #include "sysc/kernel/sc_dynamic_processes.h"

    #include "dvv_classes/dvv_queue.h"

    #include "dvv_classes/ports/dvv_bp.h"
    #include "dvv_classes/ports/dvv_ap.h"
    #include "dvv_classes/ports/dvv_aep.h"

    #include "dvv_classes/dvv_bc.h"
    #include "dvv_classes/dvv_cc.h"
    
    #include "dvv_classes/dvv_agt.h"
    #include "dvv_classes/dvv_scb.h"
    #include "dvv_classes/dvv_scr.h"
    #include "dvv_classes/dvv_mon.h"
    #include "dvv_classes/dvv_gen.h"
    #include "dvv_classes/dvv_drv.h"
    #include "dvv_classes/dvv_env.h"
    #include "dvv_classes/dvv_phase.h"
    #include "dvv_classes/dvv_test.h"

    #include "dvv_classes/dvv_res.h"
    #include "dvv_classes/dvv_res_db.h"

#endif // DVV_VM_PKG__H
