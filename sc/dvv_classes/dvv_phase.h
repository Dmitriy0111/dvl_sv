/*
*  File            :   dvv_phase.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.23
*  Language        :   SystemC
*  Description     :   This is dvv phase class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_PHASE__H
#define DVV_PHASE__H

namespace dvv_vm {

    class dvv_phase : dvv_bc
    {
        public:
            dvv_bc*     top_c;

            explicit dvv_phase(sc_module_name name);

            dvv_phase();

            void set_top(dvv_bc* top_c);
            
            void build();
            void connect();
            void run();
    };

    dvv_phase::dvv_phase(sc_module_name name) : dvv_bc(name) { }

    dvv_phase::dvv_phase() : dvv_bc("") { }

    void dvv_phase::set_top(dvv_bc* top_c) {
        this->top_c = top_c;
    }

    void dvv_phase::build() {
        cout << "Build phase start" << endl;
        top_c->build();
        this->child_l = top_c->child_l;
        this->child_num = child_l.size();
        for(unsigned int i = 0 ; i < child_num ; i++) {
            child_l[i]->build();
            for(unsigned int j = 0 ; j < child_l[i]->child_num ; j++) {
                child_l[child_num] = child_l[i]->child_l[j];
                child_num++;
            }
        }
        cout << "Build phase complete" << endl;
    }

    void dvv_phase::connect() {
        cout << "Connect phase start" << endl;
        top_c->connect();
        for(unsigned int i = 0 ; i < child_num ; i++) {
            child_l[i]->connect();
        }
        cout << "Connect phase complete" << endl;
    }
    
    void dvv_phase::run() {
        cout << "Run phase start" << endl;
        for(unsigned int i = 0 ; i < child_num ; i++) {
        //    child_l[i]->run();
        }
        cout << "Run phase complete" << endl;
    }

}

#endif // DVV_PHASE__H
