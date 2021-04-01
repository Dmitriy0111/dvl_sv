/*
*  File            : i2c_mem.sv
*  Autor           : Vlasov D.V.
*  Data            : 15.03.2021
*  Language        : SystemVerilog
*  Description     : This is i2c memory model
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef I2C_MEM__SV
`define I2C_MEM__SV

timeprecision   1ns;
timeunit        1ns;

class i2c_mem #(parameter chip_addr = 8'h42) extends dvv_bc;
    `OBJ_BEGIN( i2c_mem )

    enum int { 
        CA_s = 0,   // Chip address state
        MA_s,       // Memory address state
        RD_s,       // Received data state
        TD_s        // Transmitted data state
    } i2c_stages;

    typedef struct {
        logic   [0 : 0]     rw;
        logic   [7 : 0]     addr;
        logic   [7 : 0]     data;
    } i2c_item;

    typedef virtual i2c_if i2c_vif;

    int                 stage;

    bit     [7 : 0]     i2c_ram [2**8-1 : 0];

    i2c_vif             i2c_vif_;

    int                 chip_addr_;

    logic   [7 : 0]     rec_caddr;

    i2c_item            item;

    process             main_proc;

    event               start_detect;
    event               stop_detect;

    string              msg;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    extern task run();
    extern task clean_up();

    extern task start_wait();
    extern task stop_wait();
    extern task main();

    extern task rec_byte(ref logic [7 : 0] data);
    extern task send_byte(logic [7 : 0] data);
    extern task test_ack(ref logic [0 : 0] data);
    extern task send_ack();

    extern task save_mem(string fn);

endclass : i2c_mem

function i2c_mem::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    chip_addr_ = chip_addr << 1;
    item.rw = '0;
    stage = '0;
    foreach(i2c_ram[i])
        i2c_ram[i] = 255 - i;
    $timeformat(-9, 3, " ns", 10);
endfunction : new

task i2c_mem::build();
    
    if( !dvv_res_db#(i2c_vif)::get_res_db("i2c_if_0",i2c_vif_) )
        $fatal();
endtask : build

task i2c_mem::run();
    fork
        start_wait();
        stop_wait();
        main();
    join
endtask : run

task i2c_mem::clean_up();
    save_mem({ name , ".log" });
endtask : clean_up

task i2c_mem::start_wait();
    forever
    begin
        @(negedge i2c_vif_.sda);
        if( i2c_vif_.scl == '1 )
        begin
            ->start_detect;
            $swrite(msg,"Start detect at time %t\n", $time());
            print(msg);
        end
    end
endtask : start_wait

task i2c_mem::stop_wait();
    forever
    begin
        @(posedge i2c_vif_.sda);
        if( i2c_vif_.scl == '1 )
        begin
            ->stop_detect;
            $swrite(msg,"Stop detect at time %t\n", $time());
            print(msg);
        end
    end
endtask : stop_wait

task i2c_mem::main();
    forever
    begin
        stage = CA_s;
        fork
            for(;;)
            begin
                main_proc = process::self();
                case( stage )
                    CA_s    :
                    begin
                        wait(start_detect.triggered());
                        rec_byte(rec_caddr);
                        $swrite(msg,"Received chip addr = 0x%h at time %t\n", rec_caddr, $time());
                        print(msg);
                        if( ( rec_caddr & 8'hfe ) == chip_addr_ )
                        begin
                            item.rw = rec_caddr[0];
                            send_ack();
                            if( item.rw == '0 )
                                stage = MA_s;
                            else
                                stage = TD_s;
                        end
                    end
                    MA_s    :
                    begin
                        rec_byte(item.addr);
                        $swrite(msg,"Received memory addr = 0x%h at time %t\n", item.addr, $time());
                        print(msg);
                        send_ack();
                        stage = RD_s;
                    end
                    RD_s    :
                    begin
                        rec_byte(item.data);
                        $swrite(msg,"Received data = 0x%h at time %t\n", item.data, $time());
                        print(msg);
                        send_ack();
                        i2c_ram[item.addr] = item.data;
                        item.addr++;
                    end
                    TD_s    :
                    begin
                        logic ack_nack;
                        item.data = i2c_ram[item.addr];
                        send_byte(item.data);
                        test_ack(ack_nack);
                        if( !ack_nack )
                            item.addr++;
                        $swrite(msg,"Transmitted data = 0x%h %s at time %t\n", item.data, !ack_nack ? "ACK " : "NACK" , $time());
                        print(msg);
                    end
                endcase
            end
            begin
                wait(start_detect.triggered());
                #1;
                wait(stop_detect.triggered() || start_detect.triggered());
                if( main_proc.status != process::FINISHED )
                    main_proc.kill();
            end
        join_any
    end
endtask : main

task i2c_mem::rec_byte(ref logic [7 : 0] data);
    int bit_cnt;
    data = '0;
    bit_cnt = 7;

    repeat(8)
    begin
        @(posedge i2c_vif_.scl);
        data[bit_cnt] = i2c_vif_.sda;
        bit_cnt--;
    end
endtask : rec_byte

task i2c_mem::send_byte(logic [7 : 0] data);
    int bit_cnt;
    bit_cnt = 7;

    repeat(8)
    begin
        if( data[bit_cnt] )
            i2c_vif_.sda_release();
        else
            i2c_vif_.sda_force('0);
        bit_cnt--;
        @(negedge i2c_vif_.scl);
    end
    i2c_vif_.sda_release();
endtask : send_byte

task i2c_mem::send_ack();
    @(negedge i2c_vif_.scl);
    i2c_vif_.sda_force('0);
    @(negedge i2c_vif_.scl);
    i2c_vif_.sda_release();
endtask : send_ack

task i2c_mem::test_ack(ref logic [0 : 0] data);
    @(posedge i2c_vif_.scl);
    data = i2c_vif_.sda;
    @(negedge i2c_vif_.scl);
endtask : test_ack

task i2c_mem::save_mem(string fn);
    int fd;
    fd = $fopen(fn, "wb");
    foreach(i2c_ram[i])
        $fwrite(fd,"%h %h\n", i, i2c_ram[i]);
    $fclose(fd);
endtask : save_mem

`endif // I2C_MEM__SV
