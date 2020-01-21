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

#include <string>
#include <systemc>

#include "dvv_bc.h"

namespace dvv_vm {

    template <typename class_t>
    class dvv_cc 
    {
        static class_t* create_obj(string name, dvv_bc parent);
    };

    template <typename class_t>
    class_t* dvv_cc<class_t>::create_obj(string name, dvv_bc parent) {
        class_t* obj = new(name, parent);
        obj->fname = parent.fname + "." + name;
        cout << "Creating" << obj->fname << "object" << endl;
        return obj;
    }

}

#endif // DVV_CC__H
