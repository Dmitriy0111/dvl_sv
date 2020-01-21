/*
*  File            :   dvv_scb.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv scoreboard class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_SCB__H
#define DVV_SCB__H

#include "dvv_bc.h"

namespace dvv_vm {

    class dvv_scb : dvv_bc {
        dvv_scb(string name = "", dvv_bc parent = NULL);

        virtual void build();
        virtual void connect();
        virtual void run();
    };

    dvv_scb::dvv_scb(string name = "", dvv_bc parent = NULL) {
        dvv_bc::dvv_bc(name,parent);
    }

    void dvv_scb::build() {}
    void dvv_scb::connect() {}
    void dvv_scb::run() {}

}

#endif // DVV_SCB__H
