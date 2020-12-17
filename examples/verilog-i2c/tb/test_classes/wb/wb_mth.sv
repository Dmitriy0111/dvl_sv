/*
*  File            :   wb_mth.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.26
*  Language        :   SystemVerilog
*  Description     :   This is wishbone interface common methods 
*  Copyright(c)    :   2020 Vlasov D.V.
*/

`ifndef WB_MTH__SV
`define WB_MTH__SV

class wb_mth extends dvv_bc;
    `OBJ_BEGIN( wb_mth )

    wb_vif      ctrl_vif;

    extern function new(string name = "", dvv_bc parent = null);

    extern task set_wb_addr     (logic [31 : 0] val);
    extern task set_wb_data_i   (logic [31 : 0] val);
    extern task set_wb_data_o   (logic [31 : 0] val);
    extern task set_wb_we       (logic [0  : 0] val);
    extern task set_wb_stb      (logic [0  : 0] val);
    extern task set_wb_ack      (logic [0  : 0] val);
    extern task set_wb_cyc      (logic [0  : 0] val);

    extern function logic [31 : 0] get_wb_addr();
    extern function logic [31 : 0] get_wb_data_i();
    extern function logic [31 : 0] get_wb_data_o();
    extern function logic [0  : 0] get_wb_we();
    extern function logic [0  : 0] get_wb_stb();
    extern function logic [0  : 0] get_wb_ack();
    extern function logic [0  : 0] get_wb_cyc();

    extern task wait_clk();
    extern task wait_reset();

    extern task wait_read_cycle();
    extern task wait_write_cycle();
    
    extern task reset_signals();
    
endclass : wb_mth

function wb_mth::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task wb_mth::set_wb_addr(logic [31 : 0] val);
    ctrl_vif.wbs_adr_i = val;
endtask : set_wb_addr

task wb_mth::set_wb_data_i(logic [31 : 0] val);
    ctrl_vif.wbs_dat_i = val;
endtask : set_wb_data_i

task wb_mth::set_wb_data_o(logic [31 : 0] val);
    ctrl_vif.wbs_dat_o = val;
endtask : set_wb_data_o

task wb_mth::set_wb_we(logic [0  : 0] val);
    ctrl_vif.wbs_we_i = val;
endtask : set_wb_we

task wb_mth::set_wb_stb(logic [0  : 0] val);
    ctrl_vif.wbs_stb_i = val;
endtask : set_wb_stb

task wb_mth::set_wb_ack(logic [0  : 0] val);
    ctrl_vif.wbs_ack_o = val;
endtask : set_wb_ack

task wb_mth::set_wb_cyc(logic [0  : 0] val);
    ctrl_vif.wbs_cyc_i = val;
endtask : set_wb_cyc

function logic [31 : 0] wb_mth::get_wb_addr();
    return ctrl_vif.wbs_adr_i;
endfunction : get_wb_addr

function logic [31 : 0] wb_mth::get_wb_data_i();
    return ctrl_vif.wbs_dat_i;
endfunction : get_wb_data_i

function logic [31 : 0] wb_mth::get_wb_data_o();
    return ctrl_vif.wbs_dat_o;
endfunction : get_wb_data_o

function logic [0  : 0] wb_mth::get_wb_we();
    return ctrl_vif.wbs_we_i;
endfunction : get_wb_we

function logic [0  : 0] wb_mth::get_wb_stb();
    return ctrl_vif.wbs_stb_i;
endfunction : get_wb_stb

function logic [0  : 0] wb_mth::get_wb_ack();
    return ctrl_vif.wbs_ack_o;
endfunction : get_wb_ack

function logic [0  : 0] wb_mth::get_wb_cyc();
    return ctrl_vif.wbs_cyc_i;
endfunction : get_wb_cyc

task wb_mth::wait_clk();
    @(posedge ctrl_vif.clk);
endtask : wait_clk

task wb_mth::wait_reset();
    @(negedge ctrl_vif.rst);
endtask : wait_reset

task wb_mth::wait_read_cycle();
    while(1)
    begin
        wait_clk();
        if( ! ctrl_vif.wbs_we_i && ctrl_vif.wbs_stb_i && ctrl_vif.wbs_cyc_i && ctrl_vif.wbs_ack_o )
            break;
    end
endtask : wait_read_cycle

task wb_mth::wait_write_cycle();
    while(1)
    begin
        wait_clk();
        if(   ctrl_vif.wbs_we_i && ctrl_vif.wbs_stb_i && ctrl_vif.wbs_cyc_i && ctrl_vif.wbs_ack_o )
            break;
    end
endtask : wait_write_cycle

task wb_mth::reset_signals();
    ctrl_vif.wbs_adr_i = '0;
    ctrl_vif.wbs_dat_i = '0;
    ctrl_vif.wbs_we_i = '0;
    ctrl_vif.wbs_stb_i = '0;
    ctrl_vif.wbs_cyc_i = '0;
endtask : reset_signals

`endif // WB_MTH__SV
