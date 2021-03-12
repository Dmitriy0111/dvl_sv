/*
*  File            : lat_if.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is lattice interface
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

interface lat_if
(
    input   logic   [0 : 0]     clk,
    input   logic   [0 : 0]     rst
);

    logic   [9 : 0]     i_slave_addr_reg;           // 10-bit slave address. If 7-bit addressing mode is enabled, then the controller will take only slave_addr[6:0].
    logic   [7 : 0]     i_byte_cnt_reg;             // Sets the number of data bytes to be read or written for the I2C transacation.
    logic   [7 : 0]     i_clk_div_lsb;              // Sets the lower byte of the clock divider that is used to generate SCL from CLK. The upper three bits are located in the i_mode_reg.
    logic   [5 : 0]     i_config_reg;               // Used to configure the I2C Master Controller. (soft_reset,abort_reg,tx_ie,rx_ie,int)
    logic   [7 : 0]     i_mode_reg;                 // Sets the various modes of operation like speed, read/write. (scl_div_cnt, bps_mode, adr_mode, ack)
    logic   [7 : 0]     o_cmd_status_reg;           // Lets the user know the status of the operation.
    logic   [0 : 0]     o_start_ack;                // Acknowledge to the start bit provided by the user through i_config_reg.
    logic   [7 : 0]     i_transmit_data;            // transmit data bus
    logic   [0 : 0]     o_transmit_data_request;    // Lets the user know that transmit data is required. 
    logic   [0 : 0]     o_received_data_valid;      // A "1" corresponds to valid data availability on the o_receive_data line.
    logic   [7 : 0]     o_receive_data;             // received data bus

    logic   [0 : 0]     o_int_n;                    // Active-low interrupt signal

    // help signals
    int                 addr;
    bit     [0 : 0]     we;
    bit     [0 : 0]     re;

endinterface : lat_if
    