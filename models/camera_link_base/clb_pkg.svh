/*
*  File            : clb_pkg.sv
*  Autor           : Vlasov D.V.
*  Data            : 30.11.2021
*  Language        : SystemVerilog
*  Description     : This is camera link base package
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

package clb_pkg;
    
    typedef virtual clb_lvds_if clb_lvds_vif;

    import vcv_sv_pkg::*;

    import dvl_sv_pkg::*;
    `include "../../dvl_sv/dvl_macro.svh"

    `include "clb_drv.svh"

endpackage : clb_pkg
