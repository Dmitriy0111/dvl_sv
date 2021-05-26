/*
*  File            : dvl_macro.svh
*  Autor           : Vlasov D.V.
*  Data            : 26.12.2019
*  Language        : SystemVerilog
*  Description     : This is dvl macroses
*  Copyright(c)    : 2019 - 2021 Vlasov D.V.
*/

`ifndef DVL_MACRO__SV
`define DVL_MACRO__SV

`define OBJ_BEGIN(T) \
    const static string type_name = `"T`"; \
    typedef dvl_cc #(T) create; \
    typedef T this_type; \
    static this_type me = new(); \
    static function create get_type(); \
        return create::get(); \
    endfunction \
    static function create get_type_(); \
    return create::get(); \
    endfunction \
    static function int add_type(); \
        type_names[`"T`"] = get_type(); \
        type_bc[`"T`"] = me; \
        return 1; \
    endfunction : add_type \
    static bit registred = add_type(); \
    function T create_obj(string name = "", dvl_bc parent = null); \
    T obj; \
    obj = new(name, parent); \
    return obj; \
    endfunction : create_obj \

/*
    MACRO `dvl_ap_decl(SCR)
    -- Example of using dvl_ap_decl macro:

    `ifndef EXAMPLE__SV
    `define EXAMPLE__SV

    `dvl_ap_decl(_oth_1)
    `dvl_ap_decl(_oth_2)

    class example extends dvl_scr #(int);
        `OBJ_BEGIN( example )

        typedef example example_t;

        int                                 item_0;
        int                                 item_1;
        int                                 item_2;
        
        dvl_ap_oth_1    #(int,example_t)    ex_ap_1;
        dvl_ap_oth_2    #(int,example_t)    ex_ap_2;

        extern function new(string name = "", dvl_bc parent = null);

        extern function void write(int item);

        extern function void write_oth_1(int item);
        extern function void write_oth_2(int item);
        
    endclass : example

    function example::new(string name = "", dvl_bc parent = null);
        super.new(name,parent);
        item_ap = new(this,"item_ap");
        ex_ap_1 = new(this,"ex_ap_1");
        ex_ap_2 = new(this,"ex_ap_2");
    endfunction : new

    function void example::write(int item);
        item_0 = item;
        $info("Received item = %h", this.item_0);
    endfunction : write

    function void example::write_oth_1(int item);
        item_1 = item;
        $info("Received item = %h", this.item_1);
    endfunction : write_oth_1

    function void example::write_oth_2(int item);
        item_2 = item;
        $info("Received item = %h", this.item_2);
    endfunction : write_oth_2

    `endif // EXAMPLE__SV
*/

`define dvl_ap_decl(SCR) \
    class dvl_ap``SCR #(type item_type, type scr_type) extends dvl_bp #(item_type); \
 \
        scr_type        scr; \
 \
        extern function new(scr_type scr = null, string p_name = ""); \
 \
        extern virtual function void write(item_type item); \
 \
    endclass : dvl_ap``SCR \
 \
    function dvl_ap``SCR::new(scr_type scr = null, string p_name = ""); \
        this.scr = scr; \
        this.p_name = p_name !="" ? p_name : "unnamed_ap"; \
    endfunction : new \
 \
    function void dvl_ap``SCR::write(item_type item); \
        this.scr.write``SCR(item); \
    endfunction : write \

`endif // DVL_MACRO__SV
