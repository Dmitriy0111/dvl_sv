/*
*  File            : mipi_base_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 17.05.2021
*  Language        : SystemVerilog
*  Description     : This is mipi base monitor
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef MIPI_BASE_MON__SV
`define MIPI_BASE_MON__SV

timeprecision   1ps;
timeunit        1ps;

class mipi_base_mon extends dvv_mon #(mipi_item);
    `OBJ_BEGIN( mipi_base_mon )

    // virtual interface
    mipi_vif            vif;
    // number of tx/rx lines
    int                 line_num = 2;
    // data values
    bit     [7 : 0]     dat_0;
    bit     [7 : 0]     dat_1;
    bit     [7 : 0]     dat_2;
    bit     [7 : 0]     dat_3;
    // events
    event               start_wait_sot;
    event               start_wait_lps;
    event               sot_detect;
    event               kill_rec_proc;
    // receive process
    process             rec_proc;
    // receiver states
    typedef enum { wait_header , wait_data } rec_s;
    //
    rec_s               rec_s_ = wait_header;
    int                 pkt_num;            // packet number
    int                 sot_num;            // start of transaction
    int                 header_cnt;         // header cnt
    int                 rec_cnt;            // receiver cnt
    //
    mipi_item           item;
    byte                fecc;
    bit     [15 : 0]    calc_crc;
    bit     [15 : 0]    rec_crc;
    string              pkt_type_s;
    // message for output
    string              msg;
    // file work
    int                 fd;
    int                 wr2file_en = 1;
    //
    bit     [15 : 0]    crc16_table [256];
    bit     [15 : 0]    crc16_polynome = 16'h8408;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task run();

    extern task wait_sot();

    extern task main_rec();

    extern task wait_lps();

    extern task wait_byte();

    extern task get_bits();
    
    extern task set_arr();

    extern function byte test_ecc(bit [23 : 0] tv);

    extern task calc_crc16_table();

    extern task calc_crc16();

    extern task analysis();

endclass : mipi_base_mon

function mipi_base_mon::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task mipi_base_mon::build();
    calc_crc16_table();
endtask : build

task mipi_base_mon::run();
endtask : run

task mipi_base_mon::wait_sot();
    wait( start_wait_sot.triggered() );
    while(1) begin
        @(negedge vif.clk_p);
        if( ( dat_0 & 8'hF8 ) == 8'hB8 ) begin
            if( line_num <= 1 ) begin
                ->sot_detect;
                break;
            end
            else
            if( ( dat_1 & 8'hF8 ) == 8'hB8 ) begin
                if( line_num <= 2 ) begin
                    ->sot_detect;
                    break;
                end
                else
                if( ( dat_2 & 8'hF8 ) == 8'hB8 ) begin
                    if( line_num <= 3 ) begin
                        ->sot_detect;
                        break;
                    end
                    else
                    if( ( dat_2 & 8'hF8 ) == 8'hB8 ) begin
                        ->sot_detect;
                        break;
                    end
                end
            end
        end
    end
    rec_cnt = 0;
    
    pkt_num = 0;
    $swrite(
                msg,
                "<%s> [0x%8h][0x%8h] SoT detected at time %t\n", 
                this.name,
                sot_num,
                pkt_num,
                $time()
            );

    print(msg);
    ->start_wait_lps;
endtask : wait_sot

task mipi_base_mon::main_rec();
endtask : main_rec

task mipi_base_mon::wait_lps();
    ->start_wait_sot;
    wait( start_wait_lps.triggered );

    if( line_num >= 1)
        wait( vif.d0_p && vif.d0_n );
    if( line_num >= 2)
        wait( vif.d1_p && vif.d1_n );
    if( line_num >= 4)
        wait( vif.d2_p && vif.d2_n );
    if( line_num >= 4)
        wait( vif.d3_p && vif.d3_n );
    pkt_num++;
    $swrite(
                msg,
                "<%s> [0x%8h][0x%8h] LPS detected at time %t\n", 
                this.name,
                sot_num,
                pkt_num,
                $time()
            );
    print(msg);

    item.rec_arr_v.delete();
    rec_cnt = 0;
    header_cnt = 0;
    sot_num++;
    rec_s_ = wait_header;

    ->kill_rec_proc;
endtask : wait_lps

task mipi_base_mon::wait_byte();
    repeat(4) @(negedge vif.clk_p);
endtask : wait_byte

task mipi_base_mon::get_bits();
    dat_0 = { vif.d0_p , dat_0[7 : 1] };
    dat_1 = { vif.d1_p , dat_1[7 : 1] };
    dat_2 = { vif.d2_p , dat_2[7 : 1] };
    dat_3 = { vif.d3_p , dat_3[7 : 1] };
endtask : get_bits

task mipi_base_mon::set_arr();
    if( line_num >= 1) begin
        item.rec_arr_v[rec_cnt] = dat_0; 
        rec_cnt++;
        header_cnt++;
    end

    if( line_num >= 2) begin
        item.rec_arr_v[rec_cnt] = dat_1; 
        rec_cnt++;
        header_cnt++;
    end

    if( line_num >= 3) begin
        item.rec_arr_v[rec_cnt] = dat_2; 
        rec_cnt++;
        header_cnt++;
    end

    if( line_num >= 4) begin
        item.rec_arr_v[rec_cnt] = dat_3; 
        rec_cnt++;
        header_cnt++;
    end
endtask : set_arr

function byte mipi_base_mon::test_ecc(bit [23 : 0] tv);
    byte ret_val;

    ret_val[0] = tv[ 0  ] ^ tv[ 1  ] ^ tv[ 2  ] ^ tv[ 4  ] ^ tv[ 5  ] ^ tv[ 7  ] ^ tv[ 10 ] ^ tv[ 11 ] ^ tv[ 13 ] ^ tv[ 16 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 22 ] ^ tv[ 23 ];
    ret_val[1] = tv[ 0  ] ^ tv[ 1  ] ^ tv[ 3  ] ^ tv[ 4  ] ^ tv[ 6  ] ^ tv[ 8  ] ^ tv[ 10 ] ^ tv[ 12 ] ^ tv[ 14 ] ^ tv[ 17 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 22 ] ^ tv[ 23 ];
    ret_val[2] = tv[ 0  ] ^ tv[ 2  ] ^ tv[ 3  ] ^ tv[ 5  ] ^ tv[ 6  ] ^ tv[ 9  ] ^ tv[ 11 ] ^ tv[ 12 ] ^ tv[ 15 ] ^ tv[ 18 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 22 ];
    ret_val[3] = tv[ 1  ] ^ tv[ 2  ] ^ tv[ 3  ] ^ tv[ 7  ] ^ tv[ 8  ] ^ tv[ 9  ] ^ tv[ 13 ] ^ tv[ 14 ] ^ tv[ 15 ] ^ tv[ 19 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 23 ];
    ret_val[4] = tv[ 4  ] ^ tv[ 5  ] ^ tv[ 6  ] ^ tv[ 7  ] ^ tv[ 8  ] ^ tv[ 9  ] ^ tv[ 16 ] ^ tv[ 17 ] ^ tv[ 18 ] ^ tv[ 19 ] ^ tv[ 20 ] ^ tv[ 22 ] ^ tv[ 23 ];
    ret_val[5] = tv[ 10 ] ^ tv[ 11 ] ^ tv[ 12 ] ^ tv[ 13 ] ^ tv[ 14 ] ^ tv[ 15 ] ^ tv[ 16 ] ^ tv[ 17 ] ^ tv[ 18 ] ^ tv[ 19 ] ^ tv[ 21 ] ^ tv[ 22 ] ^ tv[ 23 ];

    return ret_val;
endfunction : test_ecc

task mipi_base_mon::calc_crc16_table();
    bit [15 : 0] crc_val;

    foreach( crc16_table[i] ) begin
        crc_val = i;

        
        repeat(8)
            crc_val = crc_val & 16'h0001 ? ( crc_val >> 1 ) ^ crc16_polynome : ( crc_val >> 1 );

        crc16_table[i] = crc_val;
    end
endtask : calc_crc16_table

task mipi_base_mon::calc_crc16();
    int index;

    calc_crc = '1;

    for ( int i = item.rec_arr_p ; i < ( item.rec_arr_p + item.mipi_h.size ) ; i++ ) begin
        index = ( calc_crc & 8'hff ) ^ item.rec_arr_v[i];
        calc_crc = ( ( calc_crc >> 8 ) ^ crc16_table[index] );
    end
endtask : calc_crc16

task mipi_base_mon::analysis();
endtask : analysis

`endif // MIPI_BASE_MON__SV
