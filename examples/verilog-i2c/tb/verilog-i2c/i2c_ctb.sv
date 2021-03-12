/* 
*  File            : i2c_ctb.sv
*  Autor           : Vlasov D.V.
*  Data            : 26.11.2020
*  Language        : SystemVerilog
*  Description     : This is testbench for i2c module
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

import i2c_test_pkg::*;
import dvv_vm_pkg::*;

module i2c_ctb();

    timeprecision       1ns;
    timeunit            1ns;

    parameter           T = 10,
                        start_del = 200,
                        rst_delay = 7,
                        repeat_n = 40;

    // reset and clock
    logic   [0  : 0]    clk;        // clk
    logic   [0  : 0]    rst;        // reset

    logic   [0  : 0]    i2c_scl_i;
    logic   [0  : 0]    i2c_scl_o;
    logic   [0  : 0]    i2c_scl_t;
    logic   [0  : 0]    i2c_sda_i;
    logic   [0  : 0]    i2c_sda_o;
    logic   [0  : 0]    i2c_sda_t;

    wire    [0  : 0]    scl_pin;
    wire    [0  : 0]    sda_pin;

    wb_if
    wb_if_0
    (
        .clk        ( clk           ),
        .rst        ( rst           )
    );

    clk_rst_if
    cr_if_0
    (
        .clk        ( clk           ),
        .rst        ( rst           )
    );

    i2c_master_wbs_8
    #(
        .CMD_FIFO       ( 1                     ),
        .WRITE_FIFO     ( 1                     ),
        .READ_FIFO      ( 1                     )
    )
    dut
    (
        // clock and reset
        .clk            ( clk                   ),
        .rst            ( rst                   ),
        // wishbone side
        .wbs_adr_i      ( wb_if_0.wbs_adr_i     ),
        .wbs_dat_i      ( wb_if_0.wbs_dat_i     ),
        .wbs_dat_o      ( wb_if_0.wbs_dat_o     ),
        .wbs_we_i       ( wb_if_0.wbs_we_i      ),
        .wbs_stb_i      ( wb_if_0.wbs_stb_i     ),
        .wbs_ack_o      ( wb_if_0.wbs_ack_o     ),
        .wbs_cyc_i      ( wb_if_0.wbs_cyc_i     ),
        // I2C side
        .i2c_scl_i      ( i2c_scl_i             ),
        .i2c_scl_o      ( i2c_scl_o             ),
        .i2c_scl_t      ( i2c_scl_t             ),
        .i2c_sda_i      ( i2c_sda_i             ),
        .i2c_sda_o      ( i2c_sda_o             ),
        .i2c_sda_t      ( i2c_sda_t             )
    );

    assign i2c_scl_i = scl_pin;
    assign scl_pin = i2c_scl_t ? 1'bz : i2c_scl_o;
    assign i2c_sda_i = sda_pin;
    assign sda_pin = i2c_sda_t ? 1'bz : i2c_sda_o;

    pullup (weak1) scl_pin_ (scl_pin);
    pullup (weak1) sda_pin_ (sda_pin);
    
    initial
    begin
        # start_del;
        clk = '0;
        forever
            #(T/2) clk = ! clk;
    end

    initial
    begin
        # start_del;
        rst = '1;
        repeat(rst_delay) @(posedge clk);
        rst = '0;
    end

    initial
    begin
        # start_del;

        dvv_res_db#( virtual wb_if )::set_res_db( "wb_if_0" , wb_if_0 );
        dvv_res_db#( virtual clk_rst_if )::set_res_db( "cr_if_0" , cr_if_0 );
        
        dvv_res_db#( integer )::set_res_db( "rep_number" , repeat_n );

        run_test("");
    end

endmodule : i2c_ctb
