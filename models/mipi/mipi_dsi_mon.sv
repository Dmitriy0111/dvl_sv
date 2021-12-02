/*
*  File            : mipi_dsi_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 11.05.2021
*  Language        : SystemVerilog
*  Description     : This is mipi dsi monitor
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef MIPI_DSI_MON__SV
`define MIPI_DSI_MON__SV

timeprecision   1ps;
timeunit        1ps;

class mipi_dsi_mon extends mipi_base_mon;
    `OBJ_BEGIN( mipi_dsi_mon )

    extern function new(string name = "", dvl_bc parent = null);

    extern task build();
    extern task run();

    extern task main_rec();

    extern task analysis();

endclass : mipi_dsi_mon

function mipi_dsi_mon::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
    item_aep = new("item_aep");
    $timeformat(-12, 3, " ps", 10);
endfunction : new

task mipi_dsi_mon::build();
    super.build();
endtask : build

task mipi_dsi_mon::run();
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

task mipi_dsi_mon::main_rec();
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

task mipi_dsi_mon::analysis();
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

                foreach( mipi_dsi_cmds[i] )
                    if( ( mipi_dsi_cmds[i].val & 8'h3F ) == ( item.mipi_h.ptype & 8'h3F ) ) begin
                        pkt_type_s = mipi_dsi_cmds[i].name;
                        item.mipi_h.psize = mipi_dsi_cmds[i].pkt_size;
                        break;
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

`endif // MIPI_DSI_MON__SV
