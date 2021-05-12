/*
*  File            : mipi_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 11.05.2021
*  Language        : SystemVerilog
*  Description     : This is mipi monitor
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef I2C_MEM__SV
`define I2C_MEM__SV

timeprecision   1ps;
timeunit        1ps;

class mipi_mon extends dvv_bc;
    `OBJ_BEGIN( mipi_mon )

    typedef struct {
        byte    val;
        bit     pkt_size;
        string  name;
    } mipi_c;

    typedef struct {
        byte    ptype;
        int     size;
        byte    ecc;
        bit     psize;
    } mipi_h;

    typedef enum bit {
        short_pkt = '0,
        long_pkt = '1
    } mipi_pkt_size;

    parameter       vsync_start_c       = 8'h01;
    parameter       vsync_end_c         = 8'h11;
    parameter       hsync_start_c       = 8'h21;
    parameter       hsync_end_c         = 8'h31;

    parameter       eotp_c              = 8'h08;

    parameter       shdn_periph_c       = 8'h22;
    parameter       turn_on_periph_c    = 8'h32;

    parameter       color_mode_off_c    = 8'h02;
    parameter       color_mode_on_c     = 8'h12;

    parameter       rgb565p_c           = 8'h0E;
    parameter       rgb666p_c           = 8'h1E;
    parameter       rgb666_c            = 8'h2E;
    parameter       rgb888_c            = 8'h3E;

    parameter       null_packet_c       = 8'h09;
    parameter       blanking_packet_c   = 8'h19;

    parameter       gen_lwrite_c        = 8'h29;
    parameter       dsc_lwrite_c        = 8'h39;

    parameter       gen_read0_c         = 8'h04;
    parameter       gen_read1_c         = 8'h14;
    parameter       gen_read2_c         = 8'h24;

    parameter       gen_write0_c        = 8'h03;
    parameter       gen_write1_c        = 8'h13;
    parameter       gen_write2_c        = 8'h23;
    
    parameter       dsc_write0_c        = 8'h05;
    parameter       dsc_write1_c        = 8'h15;
    
    parameter       dsc_read0_c         = 8'h06;
    
    parameter       reserved_0_c        = 8'h00;
    parameter       reserved_1_c        = 8'hff;

    mipi_c mipi_c_all [] = '{
        '{ vsync_start_c     , short_pkt , "vsync_start"     },
        '{ vsync_end_c       , short_pkt , "vsync_end"       },
        '{ hsync_start_c     , short_pkt , "hsync_start"     },
        '{ hsync_end_c       , short_pkt , "hsync_end"       },
        
        '{ eotp_c            , short_pkt , "eotp"            },
        
        '{ shdn_periph_c     , short_pkt , "shdn_periph"     },
        '{ turn_on_periph_c  , short_pkt , "turn_on_periph"  },

        '{ color_mode_off_c  , short_pkt , "color_mode_off"  },
        '{ color_mode_on_c   , short_pkt , "color_mode_on"   },

        '{ rgb565p_c         , long_pkt  , "rgb565p"         },
        '{ rgb666p_c         , long_pkt  , "rgb666p"         },
        '{ rgb666_c          , long_pkt  , "rgb666"          },
        '{ rgb888_c          , long_pkt  , "rgb888"          },

        '{ null_packet_c     , long_pkt  , "null_packet"     },
        '{ blanking_packet_c , long_pkt  , "blanking_packet" },
        
        '{ gen_lwrite_c      , long_pkt  , "gen_lwrite"      },
        '{ dsc_lwrite_c      , long_pkt  , "dsc_lwrite"      },
        
        '{ gen_read0_c       , short_pkt , "gen_read0"       },
        '{ gen_read1_c       , short_pkt , "gen_read1"       },
        '{ gen_read2_c       , short_pkt , "gen_read2"       },
        
        '{ gen_write0_c      , short_pkt , "gen_write0"      },
        '{ gen_write1_c      , short_pkt , "gen_write1"      },
        '{ gen_write2_c      , short_pkt , "gen_write2"      },
        
        '{ dsc_write0_c      , short_pkt , "dsc_write0"      },
        '{ dsc_write1_c      , short_pkt , "dsc_write1"      },
        
        '{ dsc_read0_c       , short_pkt , "dsc_read0"       },
        
        '{ reserved_0_c      , short_pkt , "reserved_0"      },
        '{ reserved_1_c      , short_pkt , "reserved_1"      }
    };
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
    int                 pkt_p;              // packet pointer
    int                 pkt_num;            // packet number
    int                 sot_num;            // start of transaction
    int                 header_cnt;         // header cnt
    int                 rec_cnt;            // receiver cnt
    byte                rec_arr[int];       // receive array
    //
    mipi_h              pkt;
    byte                fecc;
    bit     [15 : 0]    calc_crc;
    bit     [15 : 0]    rec_crc;
    string              pkt_type_s;
    // message for output
    string              msg;

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

    extern task find_crc16();

    extern task analysis();

endclass : mipi_mon

function mipi_mon::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    $timeformat(-12, 3, " ps", 10);
endfunction : new

task mipi_mon::build();
    if( !dvv_res_db#(mipi_vif)::get_res_db("mipi_if_0",vif) )
        $fatal();
    if( !dvv_res_db#(int)::get_res_db("line_num",line_num) )
        $fatal();
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
            "[0x%8h][0x%8h] SoT detected at time %t\n", 
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
            "[0x%8h][0x%8h] LPS detected at time %t\n", 
            sot_num,
            pkt_num,
            $time()
            );
    print(msg);

    rec_arr.delete();
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
        rec_arr[rec_cnt] = dat_0;
        rec_cnt++;
        header_cnt++;
    end

    if( line_num >= 2) begin
        rec_arr[rec_cnt] = dat_1;
        rec_cnt++;
        header_cnt++;
    end

    if( line_num >= 3) begin
        rec_arr[rec_cnt] = dat_2;
        rec_cnt++;
        header_cnt++;
    end

    if( line_num >= 4) begin
        rec_arr[rec_cnt] = dat_3;
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

task mipi_mon::find_crc16();
    bit     [15 : 0]    cur_crc;
    
    calc_crc = '1;

    for ( int i = pkt_p ; i < ( pkt_p + pkt.size ) ; i++ ) begin
        
        for (int n = 0; n < 8; n = n + 1) begin
            cur_crc = calc_crc;
            cur_crc[15] = rec_arr[ i][n] ^ cur_crc[ 0];
            cur_crc[10] = cur_crc[11]    ^ cur_crc[15];
            cur_crc[ 3] = cur_crc[ 4]    ^ cur_crc[15]; 
            calc_crc = calc_crc >> 1;
            calc_crc[15] = cur_crc[15];
            calc_crc[10] = cur_crc[10];
            calc_crc[ 3] = cur_crc[ 3];
        end
    end

endtask : find_crc16

task mipi_mon::analysis();
    case ( rec_s_ )
        wait_header:
        begin
            if ( header_cnt >= 4 ) begin
                pkt_p = rec_cnt - header_cnt;
                header_cnt -= 4;

                pkt.ptype = rec_arr[pkt_p];
                pkt.size  = { rec_arr[pkt_p+2] , rec_arr[pkt_p+1] };
                pkt.ecc   = rec_arr[pkt_p+3];
                pkt.psize = short_pkt;
                fecc = test_ecc({rec_arr[pkt_p+2],rec_arr[pkt_p+1],rec_arr[pkt_p+0]});

                pkt_p += 4;

                pkt_type_s = "";

                foreach( mipi_c_all[i] )
                    if( ( mipi_c_all[i].val & 8'h3F ) == ( pkt.ptype & 8'h3F ) ) begin
                        pkt_type_s = mipi_c_all[i].name;
                        pkt.psize = mipi_c_all[i].pkt_size;
                        break;
                    end

                if( pkt_type_s == "" ) begin
                    pkt_type_s = "Other";
                end
                
                if( pkt.psize == long_pkt )
                    rec_s_ = wait_data;
                
                // EoT
                if( ( pkt.ptype != '0 ) && ( pkt.ptype != '1 ) ) begin
                    pkt_num++;
                end
                // Generate info
                $swrite(
                            msg,
                            "[0x%8h][0x%8h] Packet: type:<%2h> size:<%4h> ecc:<%2h> fecc:<%2h> ecc_status:<%s> <%s> at time %t\n",
                            sot_num,
                            pkt_num, 
                            pkt.ptype, 
                            pkt.size, 
                            pkt.ecc, 
                            fecc, 
                            pkt.ecc == fecc ? "PASS" : "FAIL", 
                            pkt_type_s,
                            $time()
                        );
                // EoT
                if( ( pkt.ptype != '0 ) && ( pkt.ptype != '1 ) ) begin
                    print(msg);
                end
            end
        end
        wait_data:
        begin
            if( rec_cnt >= (pkt.size + 2 + pkt_p) ) begin
                header_cnt = rec_cnt - (pkt.size + 2 + pkt_p);
                rec_s_ = wait_header;
                find_crc16();
                rec_crc = { rec_arr[pkt_p + pkt.size + 1] , rec_arr[pkt_p + pkt.size + 0] };
                $swrite(
                            msg,
                            "[0x%8h][0x%8h] Packet: calc crc<%2h>: rec crc:<%2h> status:<%s> at time %t\n",
                            sot_num,
                            pkt_num,
                            calc_crc,
                            rec_crc,
                            calc_crc == rec_crc ? "PASS" : "FAIL", 
                            $time()
                        );
                print(msg);
            end
        end
    endcase
endtask : analysis

`endif // mipi_mon
