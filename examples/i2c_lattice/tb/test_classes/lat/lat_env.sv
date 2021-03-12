/*
*  File            : lat_env.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is lattice interface enviroment
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef LAT_ENV__SV
`define LAT_ENV__SV

class lat_env extends dvv_env;
    `OBJ_BEGIN( lat_env )

    tr_gen                      gen;
    lat_agt                      agt;

    dvv_sock    #(ctrl_trans)   gen2drv_sock;
    dvv_sock    #(ctrl_trans)   drv2gen_sock;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task connect();
    
endclass : lat_env

function lat_env::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task lat_env::build();
    agt = lat_agt::create::create_obj("lat_agt", this);

    gen = tr_dgen ::create::create_obj("direct_gen", this);

    gen2drv_sock = new();
    if( gen2drv_sock == null )
        $fatal("gen2drv_sock not created!");

    drv2gen_sock = new();
    if( drv2gen_sock == null )
        $fatal("drv2gen_sock not created!");
endtask : build

task lat_env::connect();
    agt.drv.item_sock.connect(gen2drv_sock);
    gen.item_sock.connect(gen2drv_sock);

    agt.drv.resp_sock.connect(drv2gen_sock);
    gen.resp_sock.connect(drv2gen_sock);
endtask : connect

`endif // LAT_ENV__SV
