/*
*  File            : wb_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 26.11.2020
*  Language        : SystemVerilog
*  Description     : This is wishbone interface monitor 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef WB_MON__SV
`define WB_MON__SV

class wb_mon extends dvv_mon #(ctrl_trans);
    `OBJ_BEGIN( wb_mon )

    string                  msg;

    ctrl_trans              item;

    wb_vif                  ctrl_vif;

    wb_mth                  mth;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task run();

    extern task pars_we();
    extern task pars_re();
    
endclass : wb_mon

function wb_mon::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    item_aep = new("item_aep");
endfunction : new

task wb_mon::build();
    if( !dvv_res_db#(wb_vif)::get_res_db("wb_if_0",ctrl_vif) )
        $fatal();

    mth = wb_mth::create::create_obj("wb_mon_mth", this);
    mth.ctrl_vif = ctrl_vif;

    item = new("wb_item", this);
endtask : build

task wb_mon::run();
    fork
        this.pars_we();
        this.pars_re();
    join_none
endtask : run

task wb_mon::pars_we();
    forever
    begin
        mth.wait_write_cycle();
        begin
            item.set_data(mth.get_wb_data_i());
            item.set_addr(mth.get_wb_addr());
            item.set_we_re(1'b1);
            item_aep.write(item);
            $swrite(msg,"WRITE_TR addr = 0x%h, data = 0x%h at time %tps\n", mth.get_wb_addr(), mth.get_wb_data_i(), $time());
            print(msg);
        end
    end
endtask : pars_we

task wb_mon::pars_re();
    forever
    begin
        mth.wait_read_cycle();
        begin
            item.set_data(mth.get_wb_data_o());
            item.set_addr(mth.get_wb_addr());
            item.set_we_re(1'b0);
            item_aep.write(item);
            $swrite(msg,"READ_TR  addr = 0x%h, data = 0x%h at time %tps\n", mth.get_wb_addr(), mth.get_wb_data_o(), $time());
            //print(msg);
        end
    end
endtask : pars_re

`endif // WB_MON__SV
