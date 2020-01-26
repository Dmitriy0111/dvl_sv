/*
*  File            :   dvv_aep.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.23
*  Language        :   SystemC
*  Description     :   This is dvv analysis export class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_AEP__H
#define DVV_AEP__H

namespace dvv_vm {

    template <typename item_type>
    class dvv_aep : public dvv_bp <item_type>
    {
        public:
            void write(item_type item);

            dvv_aep(std::string p_name = "");
    };

    template <typename item_type>
    dvv_aep<item_type>::dvv_aep(std::string p_name = "") {
        this->p_name = p_name;
        port_num = 0;
    }

    template <typename item_type>
    void dvv_aep<item_type>::write(item_type item) {
        for(unsigned int i = 0 ; i < port_num; i++)
            port_l[i]->write(item);
    }

}

#endif // DVV_AEP__H
