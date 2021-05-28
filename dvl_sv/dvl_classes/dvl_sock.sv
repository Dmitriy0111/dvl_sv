/*
*  File            : dvl_sock.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl socket
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_SOCK__SV
`define DVL_SOCK__SV

class dvl_sock #(type mail_t = int);

    const static string type_name = "dvl_sock";

    string              name;

    event               sock_e;
    mailbox #(mail_t)   sock_m;

    extern function new(string s_name = "");

    extern task connect(dvl_sock #(mail_t) oth_sock);

    extern task trig_sock();
    extern task wait_sock();

    extern task put_msg(mail_t msg);
    extern task get_msg(ref mail_t msg);

    extern task send_msg(mail_t msg);
    extern task rec_msg(ref mail_t msg);
    
endclass : dvl_sock

function dvl_sock::new(string s_name = "");
    this.name = s_name != "" ? s_name : "unnamed_sock";
    this.sock_m = new();
endfunction : new

task dvl_sock::connect(dvl_sock #(mail_t) oth_sock);
    this.sock_e = oth_sock.sock_e;
    this.sock_m = oth_sock.sock_m;
endtask : connect

task dvl_sock::trig_sock();
    -> sock_e;
endtask : trig_sock

task dvl_sock::wait_sock();
    @ sock_e;
endtask : wait_sock

task dvl_sock::put_msg(mail_t msg);
    sock_m.put(msg);
endtask : put_msg

task dvl_sock::get_msg(ref mail_t msg);
    sock_m.get(msg);
endtask : get_msg

task dvl_sock::send_msg(mail_t msg);
    this.put_msg(msg);
    this.trig_sock();
endtask : send_msg

task dvl_sock::rec_msg(ref mail_t msg);
    this.wait_sock();
    this.get_msg(msg);
endtask : rec_msg

`endif // DVL_SOCK__SV
