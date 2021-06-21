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

    extern static task         set_res_db(string path, string name, input res_t in_res);
    extern static function bit get_res_db(dvl_bc cntx, string path, string name, inout res_t out_res);
    
endclass : dvl_res_db
// TODO:
task dvl_res_db::set_res_db(string path, string name, input res_t in_res);
    dvl_res #(res_t) new_res = new(name, path, in_res);
    dvl_res #(res_t) res_q [$];
    res_q = dvl_db.find with(item.res_name == name);
    res_q = res_q.find with(item.res_path == path);

    if(res_q.size() == 0)
        dvl_db.push_back(new_res);
endtask : set_res_db
// TODO:
function bit dvl_res_db::get_res_db(dvl_bc cntx, string path, string name, inout res_t out_res);
    dvl_res #(res_t) res_q [$];

    res_q = dvl_db.find with(item.res_name == name);
    if( path != "*" )
        if( path == "" ) begin
            path = cntx.fname;

            res_q = res_q.find with(item.res_path == path);
        end

    if(res_q.size() == 0)
        return '0;
    else
    begin
        out_res = res_q[0].res_val;
        return '1;
    end

endfunction : get_res_db

`endif // DVL_RES_DB__SV
