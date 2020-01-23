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

namespace dvv_vm {

    class dvv_scb : dvv_bc {
        public:
            explicit dvv_scb(sc_module_name name);

            dvv_scb();

            virtual void build();
            virtual void connect();
            virtual void run();
    };

    dvv_scb::dvv_scb(sc_module_name name) : dvv_bc(name) { }

    dvv_scb::dvv_scb() : dvv_bc("") { }

    void dvv_scb::build() {}
    void dvv_scb::connect() {}
    void dvv_scb::run() {}

}

#endif // DVV_SCB__H
