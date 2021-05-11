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
        string  name;
    } mipi_c;

    typedef struct {
        byte    ptype;
        int     size;
        byte    ecc;
    } mipi_h;

    parameter       vsync_start_c       = 8'h01;
    parameter       vsync_end_c         = 8'h11;
    parameter       hsync_start_c       = 8'h21;
    parameter       hsync_end_c         = 8'h31;
    parameter       eotp_c              = 8'h08;
    parameter       shdn_periph_c       = 8'h22;
    parameter       turn_on_periph_c    = 8'h32;
    parameter       color_mode_off_c    = 8'h02;
    parameter       color_mode_on_c     = 8'h12;
    parameter       rgb888_c            = 8'h3E;
    parameter       blanking_packet_c   = 8'h19;
    parameter       null_packet_c       = 8'h09;
    parameter       gen_read2_c         = 8'h24;
    parameter       other_c             = 8'hxx;

    mipi_c mipi_c_all [13] = '{
        '{ vsync_start_c     , "vsync_start"     },
        '{ vsync_end_c       , "vsync_end"       },
        '{ hsync_start_c     , "hsync_start"     },
        '{ hsync_end_c       , "hsync_end"       },
        '{ eotp_c            , "eotp"            },
        '{ shdn_periph_c     , "shdn_periph"     },
        '{ turn_on_periph_c  , "turn_on_periph"  },
        '{ color_mode_off_c  , "color_mode_off"  },
        '{ color_mode_on_c   , "color_mode_on"   },
        '{ rgb888_c          , "rgb888"          },
        '{ blanking_packet_c , "blanking_packet" },
        '{ gen_read2_c       , "gen_read2_c"     },
        '{ null_packet_c     , "null_packet"     }
    };
    //
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
    event               sot_detect;
    // receiver states
    typedef enum { wait_header , wait_data } rec_s;
    //
    rec_s       rec_s_ = wait_header;
    int         pkt_p;              // packet pointer
    int         pkt_num;            // packet number
    int         header_cnt;         // header cnt
    int         rec_cnt;            // receiver cnt
    byte        rec_arr[int];       // receive array
    //
    mipi_h      pkt;
    string      pkt_type_s;
    // TODO:
    int         hook;
    //
    string      msg;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task run();

    extern task wait_sot();

    extern task wait_byte();

    extern task get_bits();
    
    extern task set_arr();

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

    ->start_wait_sot;
    fork
        forever
        begin
            @(edge vif.clk_p);
            get_bits();
        end
        forever
        begin
            wait_sot();
            rec_cnt = 0;
            $swrite(msg,"SoT detected at time %t\n", $time());
            print(msg);
        end
        forever
        begin
            wait(sot_detect.triggered);
            while(!hook) begin
                wait_byte();
                set_arr();
                analysis();
            end
            hook = 0;
            ->start_wait_sot;
            rec_arr.delete();
            rec_cnt = 0;
            header_cnt = 0;
        end
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
endtask : wait_sot

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

                pkt_p += 4;
                pkt_num++;
                pkt_type_s = "";

                foreach( mipi_c_all[i] )
                    if( mipi_c_all[i].val == pkt.ptype )
                        pkt_type_s = mipi_c_all[i].name;

                if( pkt_type_s == "" ) begin
                    pkt_type_s = "other";
                    hook = 1;
                end
                else
                if( pkt.ptype == 8'h08 ) begin
                    $swrite(msg,"EoT detected at time %t\n", $time());
                    print(msg);
                    hook = 1;
                end
                else
                if( ( pkt.size != 0 ) && ( ( pkt.ptype == rgb888_c ) || ( pkt.ptype == blanking_packet_c ) || ( pkt.ptype == null_packet_c ) ) )
                    rec_s_ = wait_data;

                $swrite(msg,"Packet<%8h>: type:<%2h> size:<%4h> ecc:<%2h> <%s> at time %t\n", pkt_num, pkt.ptype, pkt.size, pkt.ecc , pkt_type_s , $time());
                print(msg);
            end
        end
        wait_data:
        begin
            if( rec_cnt >= (pkt.size + 2 + pkt_p) ) begin
                header_cnt = rec_cnt - (pkt.size + 2 + pkt_p);
                rec_s_ = wait_header;
            end
        end
    endcase
endtask : analysis

`endif // mipi_mon
