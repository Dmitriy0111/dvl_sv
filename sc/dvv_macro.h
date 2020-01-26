/*
*  File            :   dvv_macro.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv macroses
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_MACRO__H
#define DVV_MACRO__H

#define OBJ_BEGIN(...) \
    typedef dvv_cc<__VA_ARGS__> create; \

/*
    MACRO #dvv_ap_decl(SCR)
    -- Example of using dvv_ap_decl macro:

    #ifndef EXAMPLE__H
    #define EXAMPLE__H

    dvv_ap_decl(_oth_1)
    dvv_ap_decl(_oth_2)

    class example : public dvv_scr<int> {
        public:
            OBJ_BEGIN(example)

            typedef dvv_scr<int> base_type;
            typedef example this_type;

            int     item_0;
            int     item_1;
            int     item_2;

            dvv_ap_oth_1<int,this_type>*    ex_ap_1;
            dvv_ap_oth_2<int,this_type>*    ex_ap_2;

            explicit example(sc_module_name name) : dvv_scr<int>(name) { 
                item_ap = new dvv_ap<int,base_type>(this);
                ex_ap_1 = new dvv_ap_oth_1<int,this_type>(this);
                ex_ap_2 = new dvv_ap_oth_2<int,this_type>(this);
            };

            example() { };

            void write(int item) {
                item_0 = item;
                cout << "Rec item " + this->c_fname + " " << item_0 << endl;
            };

            void write_oth_1(int item) {
                item_1 = item;
                cout << "Rec item " + this->c_fname + " " << item_1 << endl;
            };

            void write_oth_2(int item) {
                item_2 = item;
                cout << "Rec item " + this->c_fname + " " << item_2 << endl;
            };
    };

    #endif // EXAMPLE__H
*/

#define dvv_ap_decl(SCR) \
    template <typename item_type, typename scr_type> \
    class dvv_ap##SCR : public dvv_bp<item_type> \
    { \
        public: \
 \
            scr_type*        scr; \
 \
            dvv_ap##SCR(scr_type* scr = NULL, std::string p_name = ""); \
 \
            void write(item_type item); \
 \
    }; \
 \
    template <typename item_type, typename scr_type> \
    dvv_ap##SCR<item_type, scr_type>::dvv_ap##SCR(scr_type* scr = NULL, std::string p_name = "") : dvv_bp(p_name) { \
        this->scr = scr; \
        this->p_name = p_name != "" ? p_name : "unnamed_ap"; \
    } \
 \
    template <typename item_type, typename scr_type> \
    void dvv_ap##SCR<item_type, scr_type>::write(item_type item) { \
        this->scr->write##SCR(item); \
    } \

#endif // DVV_MACRO__H
