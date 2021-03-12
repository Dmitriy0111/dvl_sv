/*
*  File            : wb_cov.sv
*  Autor           : Vlasov D.V.
*  Data            : 17.12.2020
*  Language        : SystemVerilog
*  Description     : This is wishbone interface coverage unit 
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef WB_COV__SV
`define WB_COV__SV

class wb_cov extends dvv_scr #(ctrl_trans);
    `OBJ_BEGIN( wb_cov )

    ctrl_trans      cov_item;
    
    logic   [15 : 0]    presc = '0;

    extern function new(string name = "", dvv_bc parent = null);

    extern function void write(ctrl_trans item);

    covergroup cov_tr;
        coverpoint cov_item.addr 
        {
            bins status_b   = {0};
            bins fifo_s_b   = {1};
            bins cmd_addr_b = {2};
            bins command_b  = {3};
            bins data_b     = {4};
            bins pr_low_b   = {6};
            bins pr_hi_b    = {7};
        }
    endgroup

    covergroup cov_presc;
        option.at_least = 15;
        coverpoint presc
        {
            bins presc_b[8] = {[0:2**12-1]};
        }
    endgroup
    
endclass : wb_cov

function wb_cov::new(string name = "", dvv_bc parent = null);
    super.new(name,parent);
    item_ap = new(this,"wb_cov_ap");
    cov_tr = new();
    cov_presc = new();
endfunction : new

function void wb_cov::write(ctrl_trans item);
    cov_item = item;
    if( item.addr == 'h6 )
        presc[0 +: 8] = item.data;
    if( item.addr == 'h7 )
        presc[8 +: 8] = item.data;
    if( ( item.addr == 'h3 ) && ( item.data & 'h6 ) )
        cov_presc.sample();
    cov_tr.sample();
endfunction : write

`endif // WB_COV__SV
