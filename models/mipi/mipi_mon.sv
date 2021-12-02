/*
*  File            : mipi_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 17.05.2021
*  Language        : SystemVerilog
*  Description     : This is mipi monitor
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef MIPI_MON__SV
`define MIPI_MON__SV

timeprecision   1ps;
timeunit        1ps;

class mipi_mon extends dvl_mon #(mipi_item);
    `OBJ_BEGIN( mipi_mon )
    // type of mipi
    mipi_types          mipi_type;
    // interface name
    string              vif_name = "vif";
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

    extern function new(string name = "", dvl_bc parent = null);

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

endclass : mipi_mon

function mipi_mon::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
    item_aep = new("item_aep");
    $timeformat(-12, 3, " ps", 10);
endfunction : new

task mipi_mon::build();
    calc_crc16_table();

    dvl_res_db#(mipi_types)::get_res_db(this, "", "mipi_type", mipi_type);

    dvl_res_db#(string)::get_res_db(this, "", "vif_name", vif_name);

    if( !dvl_res_db#(mipi_vif)::get_res_db(this, "", vif_name, vif) )
        $fatal();
    if( !dvl_res_db#(int)::get_res_db(this, "", "line_num", line_num) )
        $fatal();
    if( !dvl_res_db#(int)::get_res_db(this, "", "wr2file_en", wr2file_en) )
        wr2file_en = '1;

    if( wr2file_en )
        fd = $fopen( { name , ".hex" },"w");
endtask : build

task mipi_mon::run();
    fork
        forever
        begin
            @(edge vif.clk_p);
            get_bits();
        end
        forever
            wait_sot();
        forever
            main_rec();
        forever
            wait_lps();
    join_none
endtask : run

task mipi_mon::wait_sot();
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

task mipi_mon::main_rec();
    fork
        begin
            rec_proc = process::self();
            wait(sot_detect.triggered);
            while(1) begin
                wait_byte();
                set_arr();
                analysis();
            end
        end
        begin
            wait(sot_detect.triggered);
            wait(kill_rec_proc.triggered);
            rec_proc.kill();
        end
    join_any
endtask : main_rec

task mipi_mon::wait_lps();
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

task mipi_mon::wait_byte();
    repeat(4) @(negedge vif.clk_p);
endtask : wait_byte

task mipi_mon::get_bits();
    dat_0 = { vif.d0_p , dat_0[7 : 1] };
    dat_1 = { vif.d1_p , dat_1[7 : 1] };
    dat_2 = { vif.d2_p , dat_2[7 : 1] };
    dat_3 = { vif.d3_p , dat_3[7 : 1] };
endtask : get_bits

task mipi_mon::set_arr();
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

function byte mipi_mon::test_ecc(bit [23 : 0] tv);
    byte ret_val;

    ret_val[0] = tv[ 0  ] ^ tv[ 1  ] ^ tv[ 2  ] ^ tv[ 4  ] ^ tv[ 5  ] ^ tv[ 7  ] ^ tv[ 10 ] ^ tv[ 11 ] ^ tv[ 13 ] ^ tv[ 16 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 22 ] ^ tv[ 23 ];
    ret_val[1] = tv[ 0  ] ^ tv[ 1  ] ^ tv[ 3  ] ^ tv[ 4  ] ^ tv[ 6  ] ^ tv[ 8  ] ^ tv[ 10 ] ^ tv[ 12 ] ^ tv[ 14 ] ^ tv[ 17 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 22 ] ^ tv[ 23 ];
    ret_val[2] = tv[ 0  ] ^ tv[ 2  ] ^ tv[ 3  ] ^ tv[ 5  ] ^ tv[ 6  ] ^ tv[ 9  ] ^ tv[ 11 ] ^ tv[ 12 ] ^ tv[ 15 ] ^ tv[ 18 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 22 ];
    ret_val[3] = tv[ 1  ] ^ tv[ 2  ] ^ tv[ 3  ] ^ tv[ 7  ] ^ tv[ 8  ] ^ tv[ 9  ] ^ tv[ 13 ] ^ tv[ 14 ] ^ tv[ 15 ] ^ tv[ 19 ] ^ tv[ 20 ] ^ tv[ 21 ] ^ tv[ 23 ];
    ret_val[4] = tv[ 4  ] ^ tv[ 5  ] ^ tv[ 6  ] ^ tv[ 7  ] ^ tv[ 8  ] ^ tv[ 9  ] ^ tv[ 16 ] ^ tv[ 17 ] ^ tv[ 18 ] ^ tv[ 19 ] ^ tv[ 20 ] ^ tv[ 22 ] ^ tv[ 23 ];
    ret_val[5] = tv[ 10 ] ^ tv[ 11 ] ^ tv[ 12 ] ^ tv[ 13 ] ^ tv[ 14 ] ^ tv[ 15 ] ^ tv[ 16 ] ^ tv[ 17 ] ^ tv[ 18 ] ^ tv[ 19 ] ^ tv[ 21 ] ^ tv[ 22 ] ^ tv[ 23 ];

    return ret_val;
endfunction : test_ecc

task mipi_mon::calc_crc16_table();
    bit [15 : 0] crc_val;

    foreach( crc16_table[i] ) begin
        crc_val = i;

        
        repeat(8)
            crc_val = crc_val & 16'h0001 ? ( crc_val >> 1 ) ^ crc16_polynome : ( crc_val >> 1 );

        crc16_table[i] = crc_val;
    end
endtask : calc_crc16_table

task mipi_mon::calc_crc16();
    int index;

    calc_crc = '1;

    for ( int i = item.rec_arr_p ; i < ( item.rec_arr_p + item.mipi_h.size ) ; i++ ) begin
        index = ( calc_crc & 8'hff ) ^ item.rec_arr_v[i];
        calc_crc = ( ( calc_crc >> 8 ) ^ crc16_table[index] );
    end
endtask : calc_crc16

task mipi_mon::analysis();
    case ( rec_s_ )
        wait_header:
        begin
            if ( header_cnt >= 4 ) begin
                item.rec_arr_p = rec_cnt - header_cnt;
                header_cnt -= 4;

                item.mipi_h.ptype = item.rec_arr_v[item.rec_arr_p];
                item.mipi_h.size  = { item.rec_arr_v[item.rec_arr_p+2] , item.rec_arr_v[item.rec_arr_p+1] };
                item.mipi_h.ecc   = item.rec_arr_v[item.rec_arr_p+3];
                item.mipi_h.psize = short_pkt;
                
                fecc = test_ecc( { item.rec_arr_v[item.rec_arr_p+2] , item.rec_arr_v[item.rec_arr_p+1] , item.rec_arr_v[item.rec_arr_p] } );

                item.rec_arr_p += 4;

                pkt_type_s = "";

                if( mipi_type == mipi_dsi ) begin
                    foreach( mipi_dsi_cmds[i] )
                        if( ( mipi_dsi_cmds[i].val & 8'h3F ) == ( item.mipi_h.ptype & 8'h3F ) ) begin
                            pkt_type_s = mipi_dsi_cmds[i].name;
                            item.mipi_h.psize = mipi_dsi_cmds[i].pkt_size;
                            break;
                        end
                end
                else if( mipi_type == mipi_csi2 ) begin
                    foreach( mipi_csi2_cmds[i] )
                    if( ( mipi_csi2_cmds[i].val & 8'h3F ) == ( item.mipi_h.ptype & 8'h3F ) ) begin
                        pkt_type_s = mipi_csi2_cmds[i].name;
                        item.mipi_h.psize = mipi_csi2_cmds[i].pkt_size;
                        break;
                    end
                end

                if( pkt_type_s == "" ) begin
                    pkt_type_s = "Other";
                end
                
                if( item.mipi_h.psize == long_pkt )
                    rec_s_ = wait_data;
                
                // EoT
                if( ( item.mipi_h.ptype != '0 ) && ( item.mipi_h.ptype != '1 ) ) begin
                    pkt_num++;
                end
                // Generate info
                $swrite(
                            msg,
                            "<%s> [0x%8h][0x%8h] Packet: type:<%2h> size:<%4h> ecc:<%2h> fecc:<%2h> ecc_status:<%s> <%s> at time %t\n",
                            this.name,
                            sot_num,
                            pkt_num,
                            item.mipi_h.ptype,
                            item.mipi_h.size,
                            item.mipi_h.ecc,
                            fecc,
                            item.mipi_h.ecc == fecc ? "PASS" : "FAIL",
                            pkt_type_s,
                            $time()
                        );
                // Not EoT ('0 and '1)
                if( ( item.mipi_h.ptype != '0 ) && ( item.mipi_h.ptype != '1 ) ) begin
                    print(msg);
                    // write packet
                    if( wr2file_en )
                        $fwrite( fd, "%2h %2h %2h %2h\n", item.rec_arr_v[item.rec_arr_p-4], item.rec_arr_v[item.rec_arr_p-3], item.rec_arr_v[item.rec_arr_p-2], item.rec_arr_v[item.rec_arr_p-1] );
                end
            end
        end
        wait_data:
        begin
            if( rec_cnt >= (item.mipi_h.size + 2 + item.rec_arr_p) ) begin
                header_cnt = rec_cnt - (item.mipi_h.size + 2 + item.rec_arr_p);
                rec_s_ = wait_header;

                calc_crc16();

                if( wr2file_en ) begin
                    // write data
                    for ( int i = item.rec_arr_p ; i < ( item.rec_arr_p + item.mipi_h.size ) ; i++ ) begin
                        $fwrite( fd, "%2h ", item.rec_arr_v[i] );
                    end
                    $fwrite( fd, "\n");
                    // write received crc
                    $fwrite( fd, "%2h %2h\n", item.rec_arr_v[item.rec_arr_p + item.mipi_h.size + 0], item.rec_arr_v[item.rec_arr_p + item.mipi_h.size + 1]);
                end

                rec_crc = { item.rec_arr_v[item.rec_arr_p + item.mipi_h.size + 1] , item.rec_arr_v[item.rec_arr_p + item.mipi_h.size + 0] };

                $swrite(
                            msg,
                            "<%s> [0x%8h][0x%8h] Packet: calc crc<%2h>: rec crc:<%2h> status:<%s> at time %t\n",
                            this.name,
                            sot_num,
                            pkt_num,
                            calc_crc,
                            rec_crc,
                            calc_crc == rec_crc ? "PASS" : "FAIL",
                            $time()
                        );
                print(msg);

                item_aep.write(item);
            end
        end
    endcase
endtask : analysis

`endif // MIPI_MON__SV
