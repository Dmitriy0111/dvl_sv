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
            std::string         c_name;
            std::string         c_fname; 

            dvv_bc*             parent;

            dvv_queue<dvv_bc>   child_l = dvv_queue<dvv_bc>(0);

            virtual void build();
            virtual void connect();
            virtual void run();

            explicit dvv_bc(sc_module_name name);
            dvv_bc();
			dvv_bc(const dvv_bc& oth);

            ~dvv_bc();

            void add_child(const dvv_bc& child);

			void print_childs();

			dvv_bc &operator =(const dvv_bc& oth);
    };

    dvv_bc::dvv_bc(sc_module_name name) : sc_module(name) {
        this->c_name = name;
        this->c_fname = name;
    }

    dvv_bc::dvv_bc() : sc_module(sc_module_name("")) { }

	dvv_bc::dvv_bc(const dvv_bc& oth) : sc_module(sc_module_name("")) {
		*this = oth;
	}

    dvv_bc::~dvv_bc() {
        //child_l.~dvv_queue();
    }

    void dvv_bc::build() {}
    void dvv_bc::connect() {}
    void dvv_bc::run() {}

    void dvv_bc::add_child(const dvv_bc& child) {
        child_l.push_back( child );
    }

	void dvv_bc::print_childs() {
		for (int i = 0; i < child_l.get_size(); i++) {
			cout << child_l[i].c_name << endl;
		}
	}

	dvv_bc& dvv_bc::operator =(const dvv_bc& oth) {
		return *this;
	}

}

#endif // DVV_BC__SV
