/*
*  File            : dvl_res_db.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl resource database
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_RES_DB__SV
`define DVL_RES_DB__SV

class dvl_res_db #(type res_t);

    const static string type_name = "dvl_res_db";

    static  dvl_res     #(res_t)    dvl_db[$];

    extern static task         set_res_db(string name, input res_t in_res);
    extern static function bit get_res_db(string name, inout res_t out_res);
    
endclass : dvl_res_db

task dvl_res_db::set_res_db(string name, input res_t in_res);
    dvl_res #(res_t) new_res = new(name, in_res);
    dvl_res #(res_t) res_q [$];
    res_q = dvl_db.find with(item.res_name == name);
    if(res_q.size() == 0)
        dvl_db.push_back(new_res);
endtask : set_res_db

function bit dvl_res_db::get_res_db(string name, inout res_t out_res);
    foreach( dvl_db[i] )
        if( dvl_db[i].res_name == name )
        begin
            out_res = dvl_db[i].res_val;
            return '1;
        end
    return '0;
endfunction : get_res_db

`endif // DVL_RES_DB__SV
