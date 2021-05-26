/*
*  File            : lat_mth.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is lattice interface common methods 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef LAT_MTH__SV
`define LAT_MTH__SV

class lat_mth extends dvl_bc;
    `OBJ_BEGIN( lat_mth )

    lat_vif     ctrl_vif;

    extern function new(string name = "", dvl_bc parent = null);

    extern task set_slave_addr_reg(logic [9 : 0] data_);
    extern task set_byte_cnt_reg(logic [7 : 0] data_);
    extern task set_clk_div_lsb(logic [7 : 0] data_);
    extern task set_config_reg(logic [5 : 0] data_);
    extern task set_mode_reg(logic [7 : 0] data_);
    extern task set_cmd_status_reg(logic [7 : 0] data_);
    extern task set_start_ack(logic [0 : 0] data_);
    extern task set_transmit_data(logic [7 : 0] data_);
    extern task set_transmit_data_request(logic [0 : 0] data_);
    extern task set_received_data_valid(logic [0 : 0] data_);
    extern task set_receive_data(logic [7 : 0] data_);
    extern task set_int_n(logic [0 : 0] data_);

    extern function logic [9 : 0] get_slave_addr_reg();
    extern function logic [7 : 0] get_byte_cnt_reg();
    extern function logic [7 : 0] get_clk_div_lsb();
    extern function logic [5 : 0] get_config_reg();
    extern function logic [7 : 0] get_mode_reg();
    extern function logic [7 : 0] get_cmd_status_reg();
    extern function logic [0 : 0] get_start_ack();
    extern function logic [7 : 0] get_transmit_data();
    extern function logic [0 : 0] get_transmit_data_request();
    extern function logic [0 : 0] get_received_data_valid();
    extern function logic [7 : 0] get_receive_data();
    extern function logic [0 : 0] get_int_n();

    extern task set_we(bit [0 : 0] data_);
    extern task set_re(bit [0 : 0] data_);
    
    extern function bit [0 : 0] get_we();
    extern function bit [0 : 0] get_re();

    extern task set_addr(int data_);
    extern function int get_addr();

    extern task wait_clk();
    extern task wait_rst();

    extern task wait_read_cycle();
    extern task wait_write_cycle();
    
endclass : lat_mth
//---------------------------------------------------------------------------//

function lat_mth::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new
//---------------------------------------------------------------------------//

task lat_mth::set_slave_addr_reg(logic [9 : 0] data_);
    ctrl_vif.i_slave_addr_reg = data_;
endtask : set_slave_addr_reg

task lat_mth::set_byte_cnt_reg(logic [7 : 0] data_);
    ctrl_vif.i_byte_cnt_reg = data_;
endtask : set_byte_cnt_reg

task lat_mth::set_clk_div_lsb(logic [7 : 0] data_);
    ctrl_vif.i_clk_div_lsb = data_;
endtask : set_clk_div_lsb

task lat_mth::set_config_reg(logic [5 : 0] data_);
    ctrl_vif.i_config_reg = data_;
endtask : set_config_reg

task lat_mth::set_mode_reg(logic [7 : 0] data_);
    ctrl_vif.i_mode_reg = data_;
endtask : set_mode_reg

task lat_mth::set_cmd_status_reg(logic [7 : 0] data_);
    ctrl_vif.o_cmd_status_reg = data_;
endtask : set_cmd_status_reg

task lat_mth::set_start_ack(logic [0 : 0] data_);
    ctrl_vif.o_start_ack = data_;
endtask : set_start_ack

task lat_mth::set_transmit_data(logic [7 : 0] data_);
    ctrl_vif.i_transmit_data = data_;
endtask : set_transmit_data

task lat_mth::set_transmit_data_request(logic [0 : 0] data_);
    ctrl_vif.o_transmit_data_request = data_;
endtask : set_transmit_data_request

task lat_mth::set_received_data_valid(logic [0 : 0] data_);
    ctrl_vif.o_received_data_valid = data_;
endtask : set_received_data_valid

task lat_mth::set_receive_data(logic [7 : 0] data_);
    ctrl_vif.o_receive_data = data_;
endtask : set_receive_data

task lat_mth::set_int_n(logic [0 : 0] data_);
    ctrl_vif.o_int_n = data_;
endtask : set_int_n
//---------------------------------------------------------------------------//

function logic [9 : 0] lat_mth::get_slave_addr_reg();
    return ctrl_vif.i_slave_addr_reg;
endfunction : get_slave_addr_reg

function logic [7 : 0] lat_mth::get_byte_cnt_reg();
    return ctrl_vif.i_byte_cnt_reg;
endfunction : get_byte_cnt_reg

function logic [7 : 0] lat_mth::get_clk_div_lsb();
    return ctrl_vif.i_clk_div_lsb;
endfunction : get_clk_div_lsb

function logic [5 : 0] lat_mth::get_config_reg();
    return ctrl_vif.i_config_reg;
endfunction : get_config_reg

function logic [7 : 0] lat_mth::get_mode_reg();
    return ctrl_vif.i_mode_reg;
endfunction : get_mode_reg

function logic [7 : 0] lat_mth::get_cmd_status_reg();
    return ctrl_vif.o_cmd_status_reg;
endfunction : get_cmd_status_reg

function logic [0 : 0] lat_mth::get_start_ack();
    return ctrl_vif.o_start_ack;
endfunction : get_start_ack

function logic [7 : 0] lat_mth::get_transmit_data();
    return ctrl_vif.i_transmit_data;
endfunction : get_transmit_data

function logic [0 : 0] lat_mth::get_transmit_data_request();
    return ctrl_vif.o_transmit_data_request;
endfunction : get_transmit_data_request

function logic [0 : 0] lat_mth::get_received_data_valid();
    return ctrl_vif.o_received_data_valid;
endfunction : get_received_data_valid

function logic [7 : 0] lat_mth::get_receive_data();
    return ctrl_vif.o_receive_data;
endfunction : get_receive_data

function logic [0 : 0] lat_mth::get_int_n();
    return ctrl_vif.o_int_n;
endfunction : get_int_n
//---------------------------------------------------------------------------//

task lat_mth::set_we(bit [0 : 0] data_);
    ctrl_vif.we = data_;
endtask : set_we

task lat_mth::set_re(bit [0 : 0] data_);
    ctrl_vif.re = data_;
endtask : set_re
//---------------------------------------------------------------------------//

function bit [0 : 0] lat_mth::get_we();
    return ctrl_vif.we;
endfunction : get_we

function bit [0 : 0] lat_mth::get_re();
    return ctrl_vif.re;
endfunction : get_re
//---------------------------------------------------------------------------//

task lat_mth::set_addr(int data_);
    ctrl_vif.addr = data_;
endtask : set_addr

function int lat_mth::get_addr();
    return ctrl_vif.addr;
endfunction : get_addr
//---------------------------------------------------------------------------//

task lat_mth::wait_clk();
    @(posedge ctrl_vif.clk);
endtask : wait_clk

task lat_mth::wait_rst();
    @(posedge ctrl_vif.rst);
endtask : wait_rst
//---------------------------------------------------------------------------//

task lat_mth::wait_read_cycle();
    while(1)
    begin
        wait_clk();
        #0;
        if( ctrl_vif.re )
            break;
    end
endtask : wait_read_cycle

task lat_mth::wait_write_cycle();
    while(1)
    begin
        wait_clk();
        #0;
        if( ctrl_vif.we )
            break;
    end
endtask : wait_write_cycle
//---------------------------------------------------------------------------//

`endif // LAT_MTH__SV
