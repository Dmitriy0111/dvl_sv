/*
*  File            : dvv_sock.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvv socket
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVV_SOCK__SV
`define DVV_SOCK__SV

class dvv_sock #(type mail_t = int);

    const static string type_name = "dvv_sock";

    event               sock_e;
    mailbox #(mail_t)   sock_m;

    extern function new();

    extern task connect(dvv_sock #(mail_t) oth_sock);

    extern task trig_sock();
    extern task wait_sock();
    extern task put_msg(mail_t msg);
    extern task get_msg(ref mail_t msg);

    extern task send_msg(mail_t msg);
    extern task rec_msg(ref mail_t msg);
    
endclass : dvv_sock

function dvv_sock::new();
    this.sock_m = new();
endfunction : new

task dvv_sock::connect(dvv_sock #(mail_t) oth_sock);
    this.sock_e = oth_sock.sock_e;
    this.sock_m = oth_sock.sock_m;
endtask : connect

task dvv_sock::trig_sock();
    -> sock_e;
endtask : trig_sock

task dvv_sock::wait_sock();
    @ sock_e;
endtask : wait_sock

task dvv_sock::put_msg(mail_t msg);
    sock_m.put(msg);
endtask : put_msg

task dvv_sock::get_msg(ref mail_t msg);
    sock_m.get(msg);
endtask : get_msg

task dvv_sock::send_msg(mail_t msg);
    this.put_msg(msg);
    this.trig_sock();
endtask : send_msg

task dvv_sock::rec_msg(ref mail_t msg);
    this.wait_sock();
    this.get_msg(msg);
endtask : rec_msg

`endif // DVV_SOCK__SV
