/*
*  File            : dvl_bo.sv
*  Autor           : Vlasov D.V.
*  Data            : 25.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl base object class
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_BO__SV
`define DVL_BO__SV

class dvl_bo;

    const static string type_name = "dvl_bo";

    static int      run_drop = 0;

    string          name;
    string          fname;

    dvl_bo          parent;

    int             level;

    static int      fp;
    
    bit             write2file = 1;
    bit             write2stdout = 1;

    static  dvl_bo  type_names[string];

    extern function new(string name = "", dvl_bo parent = null);

    extern task file_write(string msg);

    extern task stdout_write(string msg);

    extern task print(string msg = "");

    extern task raise();
    extern task drop();
    
endclass : dvl_bo

function dvl_bo::new(string name = "", dvl_bo parent = null);
    this.name = name;
    this.parent = parent;
    this.fname = name;
    level = 0;
endfunction : new

task dvl_bo::file_write(string msg);
    $fwrite(fp,msg);
endtask : file_write

task dvl_bo::stdout_write(string msg);
    $write(msg);
endtask : stdout_write

task dvl_bo::print(string msg = "");
    if( write2file )
        file_write(msg);
    if( write2stdout )
        stdout_write(msg);
endtask : print

task dvl_bo::raise();
    run_drop++;
endtask : raise

task dvl_bo::drop();
    run_drop--;
endtask : drop

`endif // DVL_BO__SV
