/*
*  File            : lat_mon.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is lattice interface monitor 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef LAT_MON__SV
`define LAT_MON__SV

class lat_mon extends dvv_mon #(ctrl_trans);
    `OBJ_BEGIN( lat_mon )

    string                  msg;

    ctrl_trans              item;

    lat_vif                 ctrl_vif;

    lat_mth                 mth;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task run();

    extern task pars_we();
    extern task pars_re();
    
endclass : lat_mon

function lat_mon::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    item_aep = new("item_aep");
endfunction : new

task lat_mon::build();
    if( !dvv_res_db#(lat_vif)::get_res_db("lat_if_0",ctrl_vif) )
        $fatal();

    mth = lat_mth::create::create_obj("lat_mon_mth", this);
    mth.ctrl_vif = ctrl_vif;

    item = new("lat_item", this);
endtask : build

task lat_mon::run();
    fork
        this.pars_we();
        this.pars_re();
    join_none
endtask : run

task lat_mon::pars_we();
    forever
    begin
        mth.wait_write_cycle();
        begin
            item.set_addr(mth.get_addr());
            case(item.get_addr())
                0   : item.set_data(mth.get_slave_addr_reg());
                1   : item.set_data(mth.get_byte_cnt_reg());
                2   : item.set_data(mth.get_clk_div_lsb());
                3   : item.set_data(mth.get_config_reg());
                4   : item.set_data(mth.get_mode_reg());
                5   : item.set_data(mth.get_cmd_status_reg());
                6   : item.set_data(mth.get_start_ack());
                7   : item.set_data(mth.get_transmit_data());
                8   : item.set_data(mth.get_transmit_data_request());
                9   : item.set_data(mth.get_received_data_valid());
                10  : item.set_data(mth.get_receive_data());
                11  : item.set_data(mth.get_int_n());
            endcase
            item.set_we_re(1'b1);
            $swrite(msg,"WRITE_TR addr = 0x%h, data = 0x%h at time %tps\n", item.get_addr(), item.get_data(), $time());
            print(msg);
        end
    end
endtask : pars_we

task lat_mon::pars_re();
    forever
    begin
        mth.wait_read_cycle();
        begin
            item.set_addr(mth.get_addr());
            case(item.get_addr())
                0   : item.set_data( mth.get_slave_addr_reg()        );
                1   : item.set_data( mth.get_byte_cnt_reg()          );
                2   : item.set_data( mth.get_clk_div_lsb()           );
                3   : item.set_data( mth.get_config_reg()            );
                4   : item.set_data( mth.get_mode_reg()              );
                5   : item.set_data( mth.get_cmd_status_reg()        );
                6   : item.set_data( mth.get_start_ack()             );
                7   : item.set_data( mth.get_transmit_data()         );
                8   : item.set_data( mth.get_transmit_data_request() );
                9   : item.set_data( mth.get_received_data_valid()   );
                10  : item.set_data( mth.get_receive_data()          );
                11  : item.set_data( mth.get_int_n()                 );
            endcase
            item.set_we_re(1'b0);
            $swrite(msg,"READ_TR  addr = 0x%h, data = 0x%h at time %tps\n", item.get_addr(), item.get_data(), $time());
            print(msg);
        end
    end
endtask : pars_re

`endif // LAT_MON__SV
