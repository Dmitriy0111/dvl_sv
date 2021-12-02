/*
*  File            : clb_drv.svh
*  Autor           : Vlasov D.V.
*  Data            : 22.06.2021
*  Language        : SystemVerilog
*  Description     : This is camera link base driver
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef CLB_DRV__SVH
`define CLB_DRV__SVH

/*
    | Line/Bit |   0   |   1   |   2   |   3   |   4   |   5   |   6   |
    |----------|-------|-------|-------|-------|-------|-------|-------|
    | 3        | Spare | B7    | B6    | G7    | G6    | R7    | R6    |
    | 2        | DVAL  | FVAL  | LVAL  | B5    | B4    | B3    | B2    |
    | 1        | B1    | B0    | G5    | G4    | G3    | G2    | G1    |
    | 0        | G0    | R5    | R4    | R3    | R2    | R1    | R0    |
*/

class clb_drv extends dvl_bc;
    `OBJ_BEGIN( clb_drv )

    typedef virtual clb_lvds_if clb_lvds_vif;

    string          vif_name = "vif";
    clb_lvds_vif    vif;

    int         Height = 800;
    int         Width  = 600;
    int         Height_i;

    string      path2folder = "example_f/";
    string      image_name = "example";
    string      in_format = "Grad";
    string      use_matrix = "pat_matrix";

    base_matrix matrix_in;

    bit     [23 : 0]    RGBV;
    int                 CTRL;

    int                 LVAL_F = 32'b001;
    int                 FVAL_F = 32'b010;
    int                 DVAL_F = 32'b100;

    int         wtbsftr = 15000;    // wait time before start first transaction
    int         fve2fvs = 10;       // frame valid end to frame valid start
    int         fvs2flv = 10;       // frame valid start to first line valid
    int         llv2fve = 10;       // last line valid to frame valid end
    int         lvs2dvs = 10;       // line valid start to data valid start
    int         lv2lv   = 10;       // line valid to line valid
    int         dve2lve = 10;       // data valid end to line valid end

    int         tx_comp [5];

    process     main_proc;

    extern function new(string name = "", dvl_bc parent = null);

    extern task build();
    extern task run();

    extern task run_main();

    extern task set_tx_components();
    extern task drv_lines();
    extern task drv_main();

endclass : clb_drv

function clb_drv::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
    // clock component
    tx_comp[0] = 7'b1100011;
endfunction : new

task clb_drv::build();
    // Image settings
    if( !dvl_res_db#(int)::get_res_db(this, "", "Height_in", Height) )
        Height = 800;

    if( !dvl_res_db#(int)::get_res_db(this, "", "Width_in", Width) )
        Width = 600;

    if( !dvl_res_db#(string)::get_res_db(this, "", "path2folder_in", path2folder) )
        path2folder = "example_f/";

    if( !dvl_res_db#(string)::get_res_db(this, "", "image_name_in", image_name) )
        image_name = "example";

    if( !dvl_res_db#(string)::get_res_db(this, "", "use_matrix_in", use_matrix) )
        use_matrix = "pat_matrix";

    if( !dvl_res_db#(string)::get_res_db(this, "", "in_format_in", in_format) )
        in_format = "Grad";
    // Image interface name
    if( !dvl_res_db#(string)::get_res_db(this, "", "vif_name", vif_name) )
        $fatal();
    // Image interface
    if( !dvl_res_db#(virtual clb_lvds_if)::get_res_db(this, "", vif_name, vif) )
        $fatal();
    // Timing settings
    if( !dvl_res_db#(int)::get_res_db(this, "", "wtbsftr", wtbsftr) )
        wtbsftr = 15000;
    if( !dvl_res_db#(int)::get_res_db(this, "", "fve2fvs", fve2fvs) )
        fve2fvs = 10;
    if( !dvl_res_db#(int)::get_res_db(this, "", "fvs2flv", fvs2flv) )
        fvs2flv = 10;
    if( !dvl_res_db#(int)::get_res_db(this, "", "llv2fve", llv2fve) )
        llv2fve = 10;
    if( !dvl_res_db#(int)::get_res_db(this, "", "lvs2dvs", lvs2dvs) )
        lvs2dvs = 10;
    if( !dvl_res_db#(int)::get_res_db(this, "", "lv2lv",   lv2lv)   )
        lv2lv = 10;
    if( !dvl_res_db#(int)::get_res_db(this, "", "dve2lve", dve2lve) )
        dve2lve = 10;

    case( use_matrix )
        "img_matrix"    : matrix_in = img_matrix ::create( Width, Height, path2folder, image_name, in_format );
        "ppm_matrix"    : matrix_in = ppm_matrix ::create( Width, Height, path2folder, image_name, in_format );
        "pat_matrix"    : matrix_in = pat_matrix ::create( Width, Height, path2folder, image_name, in_format );
        "base_matrix"   : matrix_in = base_matrix::create( Width, Height, path2folder, image_name, in_format );
        default         : $fatal();
    endcase
    matrix_in.load_matrix();
endtask : build

task clb_drv::run();
    forever
        run_main();
endtask : run

task clb_drv::run_main();
    
    vif.clk_p = '1;
    vif.clk_n = '0;

    vif.d0_p = '1;
    vif.d0_n = '0;

    vif.d1_p = '1;
    vif.d1_n = '0;

    vif.d2_p = '1;
    vif.d2_n = '0;

    vif.d3_p = '1;
    vif.d3_n = '0;

    @(posedge vif.rst);
    fork
        begin : drive_lines
            main_proc = process::self();
            CTRL = '0;
            RGBV = '0;
            set_tx_components();
            repeat(wtbsftr) begin
                drv_lines();
            end
        
            while(1) begin
                drv_main();
            end
        end
        begin : wait_reset
            @(negedge vif.rst);
            matrix_in.reset_pos();
            main_proc.kill();
        end
    join_any
    
endtask : run_main

task clb_drv::set_tx_components();
    // RGBV[23 : 16] - R
    // RGBV[15 :  8] - G
    // RGBV[7  :  0] - B
    // set clocks
    tx_comp[0] = 7'b1100011;
    // set data 0
    tx_comp[1] = { '0 , RGBV[8]       , RGBV[21 : 16] };
    // set data 1
    tx_comp[2] = { '0 , RGBV[1  :  0] , RGBV[13 :  9] };
    // set data 2
    tx_comp[3] = { '0 , CTRL[2  :  0] , RGBV[5  :  2] };
    // set data 3
    tx_comp[4] = { '0 , RGBV[7  :  6] , RGBV[15 : 14] , RGBV[23 : 22] };
endtask : set_tx_components

task clb_drv::drv_lines();
    repeat(7) begin
        vif.clk_p =   tx_comp[0][6];
        vif.clk_n = ~ tx_comp[0][6];

        vif.d0_p  =   tx_comp[1][6];
        vif.d0_n  = ~ tx_comp[1][6];

        vif.d1_p  =   tx_comp[2][6];
        vif.d1_n  = ~ tx_comp[2][6];

        vif.d2_p  =   tx_comp[3][6];
        vif.d2_n  = ~ tx_comp[3][6];

        vif.d3_p  =   tx_comp[4][6];
        vif.d3_n  = ~ tx_comp[4][6];

        tx_comp[0] <<= 1;
        tx_comp[1] <<= 1;
        tx_comp[2] <<= 1;
        tx_comp[3] <<= 1;
        tx_comp[4] <<= 1;
        @(negedge vif.clk);
    end
    tx_comp[0] >>= 7;
    tx_comp[1] >>= 7;
    tx_comp[2] >>= 7;
    tx_comp[3] >>= 7;
    tx_comp[4] >>= 7;
endtask : drv_lines

task clb_drv::drv_main();
    CTRL = '0;
    set_tx_components();
    repeat(fve2fvs) begin
        drv_lines();
    end
    CTRL = FVAL_F;
    set_tx_components();
    repeat(fvs2flv) begin
        drv_lines();
    end
    for( Height_i = 0 ; Height_i < Height ; Height_i++ ) begin
        CTRL = FVAL_F | LVAL_F;
        set_tx_components();
        repeat(lvs2dvs) begin
            drv_lines();
        end
        CTRL = FVAL_F | LVAL_F | DVAL_F;
        repeat(Width) begin
            matrix_in.get_image_RGB( RGBV );
            set_tx_components();
            drv_lines();
        end
        RGBV = '0;
        CTRL = FVAL_F | LVAL_F;
        set_tx_components();
        repeat(dve2lve) begin
            drv_lines();
        end
        CTRL = FVAL_F;
        set_tx_components();
        repeat( Height_i == ( Height - 1 ) ? llv2fve : lv2lv ) begin
            drv_lines();
        end
    end
    matrix_in.load_matrix();

endtask : drv_main

`endif // CLB_DRV__SV
