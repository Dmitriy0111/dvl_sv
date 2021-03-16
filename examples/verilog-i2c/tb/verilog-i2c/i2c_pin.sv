/*
*  File            : i2c_pin.sv
*  Autor           : Vlasov D.V.
*  Data            : 16.03.2021
*  Language        : SystemVerilog
*  Description     : This is i2c pin
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

module i2c_pin
(
    input   wire    [0 : 0]     d_i,
    input   wire    [0 : 0]     d_e,
    output  wire    [0 : 0]     d_o,
    inout   wire    [0 : 0]     d_tri
);

    assign d_tri = d_e ? 1'bz : d_i;
    assign d_o = d_tri;

endmodule : i2c_pin
