/*
*  File            :   dvv_ap.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.23
*  Language        :   SystemC
*  Description     :   This is dvv analysis port class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_AP__H
#define DVV_AP__H

namespace dvv_vm {

    template <typename item_type, typename scr_type>
    class dvv_ap : public dvv_bp<item_type>
    {
        public:

            scr_type*   scr;
            
            dvv_ap(scr_type* scr = NULL, std::string p_name = "");

            void write(item_type item);
        
    };

    template <typename item_type, typename scr_type>
    dvv_ap<item_type, scr_type>::dvv_ap(scr_type* scr = NULL, std::string p_name = "") : dvv_bp(p_name) {
        this->scr = scr;
        this->p_name = p_name != "" ? p_name : "unnamed_ap";
    }

    template <typename item_type, typename scr_type>
    void dvv_ap<item_type, scr_type>::write(item_type item) {
        this->scr->write(item);
    }

}

#endif // DVV_AP__H
