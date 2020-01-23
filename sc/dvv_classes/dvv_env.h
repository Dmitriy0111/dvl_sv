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

namespace dvv_vm {

    class dvv_env : public dvv_bc
    {
        public:
            explicit dvv_env(sc_module_name name);

            dvv_env();

            virtual void build();
            virtual void connect();
            virtual void run();
    };

    dvv_env::dvv_env(sc_module_name name) : dvv_bc(name) { }

    dvv_env::dvv_env() : dvv_bc("") { }

    void dvv_env::build() {}
    void dvv_env::connect() {}
    void dvv_env::run() {}

}

#endif // DVV_ENV__H
