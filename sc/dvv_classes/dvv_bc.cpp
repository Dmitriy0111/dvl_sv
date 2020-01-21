/*
*  File            :   dvv_bc.cpp
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv base class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_BC__CPP
#define DVV_BC__CPP

#include <iostream>
#include <systemc>

#include "dvv_bc.h"

using namespace sc_core;

namespace dvv_vm {

    dvv_bc::dvv_bc(string name = "", dvv_bc parent = NULL) {
        this->name = name;
        this->parent = parent;
        this->fname = name;

        if(parent != NULL)
            this->parent.add_child(this);
    }

    dvv_bc::~dvv_bc() {
        delete child_l;
    }

    void dvv_bc::build() {}
    void dvv_bc::connect() {}
    void dvv_bc::run() {}

    void dvv_bc::add_child(dvv_bc* child) {
        child_l.push( child );
    }

}

#endif // DVV_BC__CPP
