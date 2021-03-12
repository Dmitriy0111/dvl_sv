/* 
*  File            : i2c_lattice_ctb.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is testbench for i2c module
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

import i2c_test_pkg::*;
import dvv_vm_pkg::*;

module i2c_lattice_ctb;

    timeprecision   1ns;
    timeunit        1ns;

    parameter       T = 20,
                    rst_rep = 7;

    
    logic   [0 : 0]     clk;
    logic   [0 : 0]     rst;

    lat_if
    lat_if_0
    (
        .clk        ( clk           ),
        .rst        ( rst           )
    );

    i2c_if
    i2c_if_0
    (
        .clk        ( clk           ),
        .rst        ( rst           )
    );

    i2c_master_controller_top
    dut 
    (

        .i_clk                      ( clk                               ),
        .i_rst_n                    ( rst                               ),

        .i_slave_addr_reg           ( lat_if_0.i_slave_addr_reg         ),
        .i_byte_cnt_reg             ( lat_if_0.i_byte_cnt_reg           ),
        .i_clk_div_lsb              ( lat_if_0.i_clk_div_lsb            ),
        .i_config_reg               ( lat_if_0.i_config_reg             ),
        .i_mode_reg                 ( lat_if_0.i_mode_reg               ),
        .o_cmd_status_reg           ( lat_if_0.o_cmd_status_reg         ),
        .o_start_ack                ( lat_if_0.o_start_ack              ),
        .i_transmit_data            ( lat_if_0.i_transmit_data          ),
        .o_transmit_data_request    ( lat_if_0.o_transmit_data_request  ),
        .o_received_data_valid      ( lat_if_0.o_received_data_valid    ),
        .o_receive_data             ( lat_if_0.o_receive_data           ),

        .o_int_n                    ( lat_if_0.o_int_n                  ),

        .io_scl                     ( i2c_if_0.scl                      ),
        .io_sda                     ( i2c_if_0.sda                      )
    );
    
    pullup (weak1) scl_pin_ (i2c_if_0.scl);
    pullup (weak1) sda_pin_ (i2c_if_0.sda);

    initial
    begin
        clk = '0;
        forever
            #(T/2) clk = ! clk;
    end

    initial
    begin
        rst = '0;
        repeat(rst_rep) @(posedge clk);
        rst = '1;
    end

    initial
    begin
        #100us;
        $stop;
    end

    initial
    begin
        dvv_res_db#( virtual lat_if )::set_res_db( "lat_if_0" , lat_if_0 );
        
        run_test("");
    end

endmodule : i2c_lattice_ctb
