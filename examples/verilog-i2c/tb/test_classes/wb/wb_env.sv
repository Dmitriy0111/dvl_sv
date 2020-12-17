/*
*  File            :   wb_env.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.26
*  Language        :   SystemVerilog
*  Description     :   This is wishbone interface enviroment
*  Copyright(c)    :   2020 Vlasov D.V.
*/

`ifndef WB_ENV__SV
`define WB_ENV__SV

class wb_env extends dvv_env;
    `OBJ_BEGIN( wb_env )

    tr_gen                      gen;
    wb_agt                      agt;
    wb_cov                      cov;

    dvv_sock    #(ctrl_trans)   gen2drv_sock;
    dvv_sock    #(ctrl_trans)   drv2gen_sock;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task connect();
    
endclass : wb_env

function wb_env::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task wb_env::build();
    agt = wb_agt ::create::create_obj("wb_agt", this);

    gen = tr_dgen ::create::create_obj("direct_gen", this);

    cov = wb_cov::create::create_obj("wb_cov", this);

    gen2drv_sock = new();
    if( gen2drv_sock == null )
        $fatal("gen2drv_sock not created!");

    drv2gen_sock = new();
    if( drv2gen_sock == null )
        $fatal("drv2gen_sock not created!");
endtask : build

task wb_env::connect();
    agt.drv.item_sock.connect(gen2drv_sock);
    gen.item_sock.connect(gen2drv_sock);

    agt.drv.resp_sock.connect(drv2gen_sock);
    gen.resp_sock.connect(drv2gen_sock);

    agt.mon.item_aep.connect(cov.item_ap);
endtask : connect

`endif // WB_ENV__SV
