/*
*  File            :   dvv_scr.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.23
*  Language        :   SystemC
*  Description     :   This is dvv subscriber class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_SCR__H
#define DVV_SCR__H

namespace dvv_vm {

    template <typename item_type>
    class dvv_scr : public dvv_bc
    {
        public:
            typedef dvv_scr<item_type> scr_type;

            dvv_ap<item_type,scr_type>* item_ap;

            explicit dvv_scr(sc_module_name name);

            dvv_scr();

            virtual void write(item_type item);
    };

    template <typename item_type>
    dvv_scr<item_type>::dvv_scr(sc_module_name name) : dvv_bc(name) { }

    template <typename item_type>
    dvv_scr<item_type>::dvv_scr() : dvv_bc("") { }

    template <typename item_type>
    void dvv_scr<item_type>::write(item_type item) { 
        assert(0);
    }

}

#endif // DVV_SCR__H
