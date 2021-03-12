/*
*  File            : tr_dgen.sv
*  Autor           : Vlasov D.V.
*  Data            : 12.03.2021
*  Language        : SystemVerilog
*  Description     : This is transaction direct generator 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef TR_DGEN__SV
`define TR_DGEN__SV

class tr_dgen extends tr_gen;
    `OBJ_BEGIN( tr_dgen )

    int                     fp;
    string                  msg = "Hello World!";

    bit         [31 : 0]    addr;
    bit         [31 : 0]    data_mask;
    bit         [31 : 0]    comp;
    string                  cmd;

    ctrl_trans              resp_item;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task run();
    
endclass : tr_dgen

function tr_dgen::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    i2c_agt_aep = new();
endfunction : new

task tr_dgen::build();
    item = new("gen_item",this);
    resp_item = new("gen_resp_item",this);

    item_sock = new();
    resp_sock = new();

    if( !dvv_res_db#(virtual lat_if)::get_res_db("lat_if_0",vif) )
        $fatal();

    fp = $fopen("../examples/i2c_lattice/tb/test_classes/tr_dgen.dat", "r");
    if( fp == 0 )
        $fatal();
endtask : build

task tr_dgen::run();
    raise();
    begin
        @(posedge vif.rst);
        
        item.tr_num++;
        for(; !$feof(fp) ;)
        begin
            $fscanf(fp,"%s %h %h %h", cmd, addr, data_mask, comp);
            item.set_addr(addr);
            item.set_data(data_mask);
            item.set_we_re( ( cmd == "WR" ? '1 : '0 ) );
            case( cmd )
                "WR"    :
                begin
                    item.set_we_re( '1 );
                    item_sock.send_msg(item);
                    item_sock.wait_sock();
                end
                "RD"    :
                begin
                    item.set_we_re( '0 );
                    for(;;)
                    begin
                        item_sock.send_msg(item);
                        fork
                            resp_sock.rec_msg(resp_item);
                            item_sock.wait_sock();
                        join
                        if( ( resp_item.get_data() & data_mask ) == comp )
                        break;
                    end
                end
            endcase
        end
    end
    drop();
endtask : run

`endif // TR_DGEN__SV
