/*
*  File            : img_gen_lv_fv.svh
*  Autor           : Vlasov D.V.
*  Data            : 22.06.2021
*  Language        : SystemVerilog
*  Description     : This is image generator with frame/line/data valid signals
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef IMG_GEN_LV_FV__SVH
`define IMG_GEN_LV_FV__SVH

class img_gen_lv_fv extends dvl_bc;
    `OBJ_BEGIN( img_gen_lv_fv )

    typedef virtual lv_fv_data lfd_vif;

    lfd_vif     vif;

    int         Height = 800;
    int         Width  = 600;
    int         Height_i;

    string      path2folder = "example_f/";
    string      image_name = "example";
    string      in_format = "Grad";
    string      use_matrix = "pat_matrix";

    base_matrix matrix_in;

    bit     [7 : 0]     R;
    bit     [7 : 0]     G;
    bit     [7 : 0]     B;

    bit     [23 : 0]    RGB;

    int         fve2fvs = 10;   // frame valid end to frame valid start
    int         fvs2flv = 10;   // frame valid start to first line valid
    int         llv2fve = 10;   // last line valid to frame valid end
    int         lvs2dvs = 10;   // line valid start to data valid start
    int         lv2lv   = 10;   // line valid to line valid
    int         dve2lve = 10;   // data valid end to line valid end

    extern function new(string name = "", dvl_bc parent = null);

    extern task build();
    extern task run();

endclass : img_gen_lv_fv

function img_gen_lv_fv::new(string name = "", dvl_bc parent = null);
    super.new(name,parent);
endfunction : new

task img_gen_lv_fv::build();
    // Image settings
    if( !dvl_res_db#(int)::get_res_db(this, "", "Height_in", Height) )
        Height = 800;

    if( !dvl_res_db#(int)::get_res_db(this, "", "Width_in", Width) )
        Width = 800;

    if( !dvl_res_db#(string)::get_res_db(this, "", "path2folder_in", path2folder) )
        path2folder = "example_f/";

    if( !dvl_res_db#(string)::get_res_db(this, "", "image_name_in", image_name) )
        image_name = "example";

    if( !dvl_res_db#(string)::get_res_db(this, "", "use_matrix_in", use_matrix) )
        use_matrix = "pat_matrix";

    if( !dvl_res_db#(string)::get_res_db(this, "", "in_format_in", in_format) )
        in_format = "Grad";
    // Image interface
    if( !dvl_res_db#(virtual lv_fv_data)::get_res_db(this, "", "img_if", vif) )
        $fatal();
    // Timing settings
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

task img_gen_lv_fv::run();
    vif.R = '0;
    vif.G = '0;
    vif.B = '0;

    vif.DV = '0;
    vif.LV = '0;
    vif.FV = '0;
    @(posedge vif.rst);
    forever begin
        repeat(fve2fvs) @(posedge vif.clk);
        vif.FV = '1;
        repeat(fvs2flv) @(posedge vif.clk);
        for( Height_i = 0 ; Height_i < Height ; Height_i++ ) begin
            vif.LV = '1;
            repeat(lvs2dvs) @(posedge vif.clk);
            vif.DV = '1;
            repeat(Width) begin
                matrix_in.get_image_RGB( RGB );
                vif.R = RGB[0  +: 8];
                vif.G = RGB[7  +: 8];
                vif.B = RGB[15 +: 8];
                @(posedge vif.clk);
            end
            vif.DV = '0;
            repeat(dve2lve) @(posedge vif.clk);
            vif.LV = '0;
            if( Height_i == ( Height - 1 ) )
                repeat(llv2fve) @(posedge vif.clk);
            else
                repeat(lv2lv) @(posedge vif.clk);
        end
        vif.FV = '0;
        matrix_in.load_matrix();
    end
endtask : run

`endif // IMG_GEN_LV_FV__SVH
