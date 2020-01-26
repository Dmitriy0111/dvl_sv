/*
*  File            :   dvv_mon.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.24
*  Language        :   SystemC
*  Description     :   This is dvv monitor class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_MON__H
#define DVV_MON__H

namespace dvv_vm {

    template<typename item_type>
    class dvv_mon : public dvv_bc
    {
        public:
            dvv_aep<item_type>*     mon_aep;

            explicit dvv_mon(sc_module_name name);
            dvv_mon();
    };

    template<typename item_type>
    dvv_mon<item_type>::dvv_mon(sc_module_name name) : dvv_bc(name) { }

    template<typename item_type>
    dvv_mon<item_type>::dvv_mon() : dvv_bc("") { }

}

#endif // DVV_MON__H
