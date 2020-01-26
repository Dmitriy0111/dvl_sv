/*
*  File            :   dvv_gen.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.24
*  Language        :   SystemC
*  Description     :   This is dvv monitor class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_GEN__H
#define DVV_GEN__H

namespace dvv_vm {

    template <typename item_type, typename resp_type=item_type>
    class dvv_gen : public dvv_bc 
    {
        public:
            //dvv_sock<item_type>     item_sock;
            //dvv_sock<resp_type>     resp_sock;

            explicit dvv_gen(sc_module_name name);
            dvv_gen();
    };

    template<typename item_type, typename resp_type=item_type>
    dvv_gen<item_type,resp_type>::dvv_gen(sc_module_name name) : dvv_bc(name) { }

    template<typename item_type, typename resp_type=item_type>
    dvv_gen<item_type,resp_type>::dvv_gen() : dvv_bc("") { }

}

#endif // DVV_GEN__H
