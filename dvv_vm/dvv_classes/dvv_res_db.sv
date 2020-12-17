/*
*  File            :   dvv_res_db.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv resource database
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_RES_DB__SV
`define DVV_RES_DB__SV

class dvv_res_db #(type res_t);

    const static string type_name = "dvv_res_db";

    static  dvv_res     #(res_t)    dvv_db[$];

    extern static task         set_res_db(string name, input res_t in_res);
    extern static function bit get_res_db(string name, inout res_t out_res);
    
endclass : dvv_res_db

task dvv_res_db::set_res_db(string name, input res_t in_res);
    dvv_res #(res_t) new_res = new(name, in_res);
    dvv_res #(res_t) res_q [$];
    res_q = dvv_db.find with(item.res_name == name);
    if(res_q.size() == 0)
        dvv_db.push_back(new_res);
endtask : set_res_db

function bit dvv_res_db::get_res_db(string name, inout res_t out_res);
    foreach( dvv_db[i] )
        if( dvv_db[i].res_name == name )
        begin
            out_res = dvv_db[i].res_val;
            return '1;
        end
    return '0;
endfunction : get_res_db

`endif // DVV_RES_DB__SV
