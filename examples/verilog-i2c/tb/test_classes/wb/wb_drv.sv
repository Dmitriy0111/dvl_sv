/*
*  File            :   wb_drv.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.26
*  Language        :   SystemVerilog
*  Description     :   This is wishbone interface driver 
*  Copyright(c)    :   2020 Vlasov D.V.
*/

`ifndef WB_DRV__SV
`define WB_DRV__SV

class wb_drv extends dvv_drv #(ctrl_trans);
    `OBJ_BEGIN( wb_drv )

    ctrl_trans                  item;
    ctrl_trans                  resp_item;

    wb_vif                      ctrl_vif;

    wb_mth                      mth;

    extern function new(string name = "", dvv_bc parent = null);

    extern task write_reg();
    extern task read_reg();

    extern task build();
    extern task run();
    
endclass : wb_drv

function wb_drv::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task wb_drv::build();
    if( !dvv_res_db#(wb_vif)::get_res_db("wb_if_0",ctrl_vif) )
        $fatal();

    mth = wb_mth::create::create_obj("wb_drv_mth", this);
    mth.ctrl_vif = ctrl_vif;

    item = new("wb_drv_item", this);
    resp_item = new("wb_drv_resp_item", this);

    item_sock = new();
    resp_sock = new();
endtask : build

task wb_drv::write_reg();
    mth.set_wb_addr(item.get_addr());
    mth.set_wb_data_i(item.get_data());
    mth.set_wb_we('1);
    mth.set_wb_stb('1);
    mth.set_wb_cyc('1);
    do
    begin
        mth.wait_clk();
    end
    while( !mth.get_wb_ack() );
    mth.set_wb_we('0);
    mth.set_wb_stb('0);
    mth.set_wb_cyc('0);
endtask : write_reg

task wb_drv::read_reg();
    mth.set_wb_addr(item.get_addr());
    mth.set_wb_we('0);
    mth.set_wb_stb('1);
    mth.set_wb_cyc('1);
    do
    begin
        mth.wait_clk();
    end
    while( !mth.get_wb_ack() );
    mth.set_wb_we('0);
    mth.set_wb_stb('0);
    mth.set_wb_cyc('0);
    resp_item.data = mth.get_wb_data_o();
    resp_sock.send_msg(resp_item);
endtask : read_reg

task wb_drv::run();        
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

`endif // WB_DRV__SV
