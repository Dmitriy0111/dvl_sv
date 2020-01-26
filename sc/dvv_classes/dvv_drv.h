/*
*  File            :   dvv_drv.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.24
*  Language        :   SystemC
*  Description     :   This is dvv driver class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_DRV__H
#define DVV_DRV__H

namespace dvv_vm {

template <typename item_type, typename resp_type=item_type>
    class dvv_drv : public dvv_bc 
    {
        public:
            //dvv_sock<item_type>     item_sock;
            //dvv_sock<resp_type>     resp_sock;

            explicit dvv_drv(sc_module_name name);
            dvv_drv();
    };

    template<typename item_type, typename resp_type=item_type>
    dvv_drv<item_type,resp_type>::dvv_drv(sc_module_name name) : dvv_bc(name) { }

    template<typename item_type, typename resp_type=item_type>
    dvv_drv<item_type,resp_type>::dvv_drv() : dvv_bc("") { }

}

#endif // DVV_DRV__H
