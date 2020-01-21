/*
*  File            :   dvv_env.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv enviroment class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_ENV__H
#define DVV_ENV__H

#include "dvv_bc.h"

namespace dvv_vm {

    class dvv_env : public dvv_bc
    {
        dvv_env(string name = "", dvv_bc parent = NULL);

        virtual void build();
        virtual void connect();
        virtual void run();
    };

    dvv_env::dvv_env(string name = "", dvv_bc parent = NULL) {
        dvv_bc::dvv_bc(name,parent);
    }

    void dvv_env::build() {}
    void dvv_env::connect() {}
    void dvv_env::run() {}

}

#endif // DVV_ENV__H
