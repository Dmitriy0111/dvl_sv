/*
*  File            :   dvv_bc.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv base class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_BC__H
#define DVV_BC__H

#include <iostream>
#include <queue>

#include "sysc/kernel/sc_module.h"
#include "sysc/kernel/sc_process_handle.h"

namespace dvv_vm {

    class dvv_bc : public sc_core::sc_module
    {

        public:
            string              name;
            string              fname;

            dvv_bc*             parent;
            queue   <dvv_bc>    child_l;

            virtual void build();
            virtual void connect();
            virtual void run();

        private:
            void add_child(dvv_bc* child);
    };

}

#endif // DVV_BC__SV
