/*
*  File            :   dvv_agt.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv agent class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_AGT__H
#define DVV_AGT__H

namespace dvv_vm {

    class dvv_agt : public dvv_bc
    {
        public:
            explicit dvv_agt(const std::string name);

            virtual void build();
            virtual void connect();
            virtual void run();
    };

    dvv_agt::dvv_agt(const std::string name) : dvv_bc(name) {
        dvv_bc::dvv_bc(name);
    }

    void dvv_agt::build() {}
    void dvv_agt::connect() {}
    void dvv_agt::run() {}

}

#endif // DVV_AGT__H
