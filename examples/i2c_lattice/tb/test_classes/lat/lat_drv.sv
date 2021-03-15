/*
*  File            : lat_drv.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is lattice interface driver 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef LAT_DRV__SV
`define LAT_DRV__SV

class lat_drv extends dvv_drv #(ctrl_trans);
    `OBJ_BEGIN( lat_drv )

    ctrl_trans      item;
    ctrl_trans      resp_item;

    lat_vif         ctrl_vif;

    lat_mth         mth;

    extern function new(string name = "", dvv_bc parent = null);

    extern task write_reg();
    extern task read_reg();

    extern task build();
    extern task run();
    
endclass : lat_drv

function lat_drv::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task lat_drv::build();
    if( !dvv_res_db#(lat_vif)::get_res_db("lat_if_0",ctrl_vif) )
        $fatal();

    mth = lat_mth::create::create_obj("lat_drv_mth", this);
    mth.ctrl_vif = ctrl_vif;

    item = new("lat_drv_item", this);
    resp_item = new("lat_drv_resp_item", this);

    item_sock = new();
    resp_sock = new();
endtask : build

task lat_drv::write_reg();
    mth.set_we('1);
    mth.set_addr(item.get_addr());
    case(item.get_addr())
        0   : mth.set_slave_addr_reg        ( item.get_data() );
        1   : mth.set_byte_cnt_reg          ( item.get_data() );
        2   : mth.set_clk_div_lsb           ( item.get_data() );
        3   : mth.set_config_reg            ( item.get_data() );
        4   : mth.set_mode_reg              ( item.get_data() );
        5   : mth.set_cmd_status_reg        ( item.get_data() );
        6   : mth.set_start_ack             ( item.get_data() );
        7   : mth.set_transmit_data         ( item.get_data() );
        8   : mth.set_transmit_data_request ( item.get_data() );
        9   : mth.set_received_data_valid   ( item.get_data() );
        10  : mth.set_receive_data          ( item.get_data() );
        11  : mth.set_int_n                 ( item.get_data() );
    endcase
    mth.wait_clk();
    mth.set_we('0);
endtask : write_reg

task lat_drv::read_reg();
    mth.set_re('1);
    mth.set_addr(item.get_addr());
    case(item.get_addr())
        0   : resp_item.set_data( mth.get_slave_addr_reg()        );
        1   : resp_item.set_data( mth.get_byte_cnt_reg()          );
        2   : resp_item.set_data( mth.get_clk_div_lsb()           );
        3   : resp_item.set_data( mth.get_config_reg()            );
        4   : resp_item.set_data( mth.get_mode_reg()              );
        5   : resp_item.set_data( mth.get_cmd_status_reg()        );
        6   : resp_item.set_data( mth.get_start_ack()             );
        7   : resp_item.set_data( mth.get_transmit_data()         );
        8   : resp_item.set_data( mth.get_transmit_data_request() );
        9   : resp_item.set_data( mth.get_received_data_valid()   );
        10  : resp_item.set_data( mth.get_receive_data()          );
        11  : resp_item.set_data( mth.get_int_n()                 );
    endcase
    mth.wait_clk();
    mth.set_re('0);
    resp_sock.send_msg(resp_item);
endtask : read_reg

task lat_drv::run();        
    forever
    begin
        item_sock.rec_msg(item);
        
        if( item.get_we_re() )
            write_reg();
        else
            read_reg();
        item_sock.trig_sock();
    end
endtask : run

`endif // LAT_DRV__SV
