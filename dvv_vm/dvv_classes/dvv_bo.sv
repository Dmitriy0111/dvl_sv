/*
*  File            :   dvv_bo.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2019.12.25
*  Language        :   SystemVerilog
*  Description     :   This is dvv base object class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

`ifndef DVV_BO__SV
`define DVV_BO__SV

class dvv_bo;

    static int      run_drop = 0;

    string          name;
    string          fname;

    dvv_bo          parent;

    int             level;

    static int      fp;
    
    bit             write2file = 1;
    bit             write2stdout = 1;

    static  dvv_bo  type_names[string];

    extern function new(string name = "", dvv_bo parent = null);

    extern task file_write(string msg);

    extern task stdout_write(string msg);

    extern task print(string msg = "");

    extern task raise();
    extern task drop();
    
endclass : dvv_bo

function dvv_bo::new(string name = "", dvv_bo parent = null);
    this.name = name;
    this.parent = parent;
    this.fname = name;
    level = 0;
endfunction : new

task dvv_bo::file_write(string msg);
    $fwrite(fp,msg);
endtask : file_write

task dvv_bo::stdout_write(string msg);
    $write(msg);
endtask : stdout_write

task dvv_bo::print(string msg = "");
    if( write2file )
        file_write(msg);
    if( write2stdout )
        stdout_write(msg);
endtask : print

task dvv_bo::raise();
    run_drop++;
endtask : raise

task dvv_bo::drop();
    run_drop--;
endtask : drop

`endif // DVV_BO__SV
