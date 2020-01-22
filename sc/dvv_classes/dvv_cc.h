/*
*  File            :   dvv_cc.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv creator class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_CC__H
#define DVV_CC__H

namespace dvv_vm {

    template <typename class_t>
    class dvv_cc 
    {
        public:
            static class_t* create_obj(const sc_module_name name, dvv_bc* parent = NULL);
    };

    template <typename class_t>
    class_t* dvv_cc<class_t>::create_obj(const sc_module_name name, dvv_bc* parent = NULL) {
        class_t* obj = new class_t(name);
        obj->parent = parent;
        parent->add_child(*obj);
        cout << "Creating " << obj->c_fname << " object" << endl;
        return obj;
    }

}

#endif // DVV_CC__H
