/*
*  File            :   dvv_bp.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.23
*  Language        :   SystemC
*  Description     :   This is dvv base port class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_BP__H
#define DVV_BP__H

namespace dvv_vm {

    template <typename item_type>
    class dvv_bp
    {
        public:
            typedef std::map< int, dvv_bp*> port_map;

            port_map        port_l;
            unsigned int    port_num;

            virtual void connect(dvv_bp<item_type>* oth);

            virtual void write(item_type item);
    };

    template <typename item_type>
    void dvv_bp<item_type>::connect(dvv_bp<item_type>* oth) {
        port_l[port_num] = oth;
        port_num++;
    }

    template <typename item_type>
    void dvv_bp<item_type>::write(item_type item) { }
}

#endif // DVV_BP__H
