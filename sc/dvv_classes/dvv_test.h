/*
*  File            :   dvv_test.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.23
*  Language        :   SystemVerilog
*  Description     :   This is dvv test class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_TEST__H
#define DVV_TEST__H

namespace dvv_vm {

    class dvv_test : public dvv_bc
    {
        public:
            dvv_phase*  phase;

            explicit dvv_test(sc_module_name name);

            dvv_test();

            virtual void test_start();
        
    };

    dvv_test::dvv_test(sc_module_name name) : dvv_bc(name) { 
        phase = new dvv_phase("phase");
        phase->set_top(this);
    }

    dvv_test::dvv_test() : dvv_bc("") { }

    void dvv_test::test_start() {
        phase->build();
        phase->connect();
        phase->run();
    }

}

#endif // DVV_TEST__H
