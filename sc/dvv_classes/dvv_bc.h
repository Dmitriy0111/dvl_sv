/*
*  File            :   dvv_bc.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv base class
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_BC__H
#define DVV_BC__H

namespace dvv_vm {

    class dvv_bc : public sc_core::sc_module
    {
    public:
        typedef std::map< int, dvv_bc*> child_map;
        typedef child_map::const_iterator child_map_IT;

        std::string         c_name;
        std::string         c_fname;

        unsigned int        level;

        dvv_bc*             parent;
        
        child_map           child_l;
        unsigned int        child_num;

        virtual void build();
        virtual void connect();
        virtual void run();

        explicit dvv_bc(sc_module_name name);
        dvv_bc();

        void print_map();
        void print_childs();

        void add_child_(dvv_bc* child);

        dvv_bc &operator =(const dvv_bc& oth);
    };

    dvv_bc::dvv_bc(sc_module_name name) : sc_module(name) {
        this->c_name = name;
        this->c_fname = name;
        child_num = 0;
        level = 0;
    }

    dvv_bc::dvv_bc() : sc_module(sc_module_name("")) {
        child_num = 0;
        level = 0;
    }

    void dvv_bc::build() {}
    void dvv_bc::connect() {}
    void dvv_bc::run() {}

    void dvv_bc::add_child_(dvv_bc* child) {
        child_l[child_num] = child;
        child_num++;
    }

    void dvv_bc::print_map() {
        for (unsigned int i = 0; i < level; i++)
            cout << "    ";
        cout << this->c_name << endl;
        for (unsigned i = 0; i < child_num; i++) {
            child_l[i]->print_childs();
        }
    }

    void dvv_bc::print_childs() {
        this->print_map();
    }

    dvv_bc& dvv_bc::operator =(const dvv_bc& oth) {
        return (dvv_bc&) oth;
    }

}

#endif // DVV_BC__SV
