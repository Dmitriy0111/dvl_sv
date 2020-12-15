/*
*  File            :   i2c_test.sv
*  Autor           :   Vlasov D.V.
*  Data            :   2020.11.26
*  Language        :   SystemVerilog
*  Description     :   This is i2c simple test
*  Copyright(c)    :   2020 Vlasov D.V.
*/

`ifndef I2C_TEST__SV
`define I2C_TEST__SV

class i2c_test extends dvv_test;
    `OBJ_BEGIN( i2c_test )

    string                  if_name;

    dvv_bc                  env;

    extern function new(string name = "", dvv_bc parent = null);

    extern task build();
    
endclass : i2c_test

function i2c_test::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
endfunction : new

task i2c_test::build();
    super.build();
    env = wb_env::create::create_obj("i2c_env", this);
endtask : build

`endif // I2C_TEST__SV