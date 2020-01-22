#include "systemc.h"

#include "dvv_vm_pkg.h"
#include "dvv_macro.h"

using namespace std;
using namespace dvv_vm;

class vif {
public:
	string name;
	int    val;
	double vald;
	vif(string name, int val, double vald) {
		this->name = name;
		this->val = val;
		this->vald = vald;
	}
	vif() { }
	void print() {
		cout << this->name << " " << this->val << " " << this->vald << endl;
	}
};

class uart_bc : public dvv_bc {
public:
	OBJ_BEGIN(uart_bc)

	explicit uart_bc(sc_module_name name) : dvv_bc(name) { };

	uart_bc() { };

	uart_bc &operator =(const uart_bc& oth) {
		return *this;
	}
};

int sc_main(int, char **)
{

	int i_0 = 70;
	int i_1 = 40;
	int i_2 = 50;
	double d_0 = 10.1;
	double d_1 = 20.2;
	double d_2 = 30.3;

	vif* vif_0 = new vif("apb", 10, 10.1);
	vif* vif_1 = new vif("sif", 20, 20.2);
	vif* vif_2 = new vif("ahb", 30, 30.3);

	dvv_queue<vif> vif_q = dvv_queue<vif>(0);

	vif_q.push_back(*vif_0);
	vif_q.push_back(*vif_1);
	vif_q.push_back(*vif_2);

	//sc_start(10000, SC_NS);
	uart_bc* test_bc = new uart_bc("test_top");
	uart_bc* test_bc_0 = new uart_bc("test_bc_0");
	uart_bc* test_bc_1 = new uart_bc("test_bc_1");
	uart_bc* test_bc_p;
	uart_bc* test_child_0;// = new uart_bc("test_top");
	uart_bc* test_child_1;// = new uart_bc("test_top");
	
	dvv_queue<dvv_bc> dvv_bc_q = dvv_queue<dvv_bc>(0);

	dvv_bc_q.push_back(*test_bc);

	test_child_0 = uart_bc::create::create_obj("test_child_0", test_bc);
	test_child_1 = uart_bc::create::create_obj("test_child_1", test_bc);

	test_bc->print_childs();

	int i = 0;
	double d = 0;
	vif* vif_p;
	
	dvv_queue<int> test_q = dvv_queue<int>(0);


	cout << "test_q size = " << test_q.get_size() << endl;
	cout << "Push items back in test_q" << endl;

	test_q.push_back(10);
	test_q.push_back(20);
	test_q.push_back(30);

	cout << "Push items front in test_q" << endl;

	test_q.push_front(70);
	test_q.push_front(80);
	test_q.push_front(90);

	cout << "test_q size = " << test_q.get_size() << endl;

	for (int i = 0; i < test_q.get_size(); i++) {
		cout << "test_q[" << i << "] = " << test_q[i] << endl;
	}

	cout << "Pop item front from test_q" << endl;
	test_q.pop_front(i);
	cout << "Poped value = " << i << endl;
	cout << "Pop item back from test_q" << endl;
	test_q.pop_back(i);
	cout << "Poped value = " << i << endl;
	cout << "test_q size = " << test_q.get_size() << endl;
	for (int i = 0; i < test_q.get_size(); i++) {
		cout << "test_q[" << i << "] = " << test_q[i] << endl;
	}

	dvv_vm::dvv_res_db<int>::set_res_db("i_0", i_0);
	dvv_vm::dvv_res_db<int>::set_res_db("i_1", i_1);
	dvv_vm::dvv_res_db<int>::set_res_db("i_2", i_2);

	dvv_vm::dvv_res_db<double>::set_res_db("d_0", d_0);
	dvv_vm::dvv_res_db<double>::set_res_db("d_1", d_1);
	dvv_vm::dvv_res_db<double>::set_res_db("d_2", d_2);

	dvv_vm::dvv_res_db<vif*>::set_res_db("vif_0", vif_0);
	dvv_vm::dvv_res_db<vif*>::set_res_db("vif_1", vif_1);
	dvv_vm::dvv_res_db<vif*>::set_res_db("vif_2", vif_2);

	dvv_vm::dvv_res_db<uart_bc*>::set_res_db("test_bc", test_bc);
	dvv_vm::dvv_res_db<uart_bc*>::set_res_db("test_bc_0", test_bc_0);
	dvv_vm::dvv_res_db<uart_bc*>::set_res_db("test_bc_1", test_bc_1);

	dvv_vm::dvv_res_db<int>::get_res_db("i_0", i);
	cout << "i_0 = " << i << endl;
	dvv_vm::dvv_res_db<int>::get_res_db("i_1", i);
	cout << "i_1 = " << i << endl;
	dvv_vm::dvv_res_db<int>::get_res_db("i_2", i);
	cout << "i_2 = " << i << endl;

	dvv_vm::dvv_res_db<double>::get_res_db("d_0", d);
	cout << "d_0 = " << d << endl;
	dvv_vm::dvv_res_db<double>::get_res_db("d_1", d);
	cout << "d_1 = " << d << endl;
	dvv_vm::dvv_res_db<double>::get_res_db("d_2", d);
	cout << "d_2 = " << d << endl;

	dvv_vm::dvv_res_db<vif*>::get_res_db("vif_0", vif_p);
	vif_p->print();
	dvv_vm::dvv_res_db<vif*>::get_res_db("vif_1", vif_p);
	vif_p->print();
	dvv_vm::dvv_res_db<vif*>::get_res_db("vif_2", vif_p);
	vif_p->print();

	dvv_vm::dvv_res_db<uart_bc*>::get_res_db("test_bc", test_bc_p);
	dvv_vm::dvv_res_db<uart_bc*>::get_res_db("test_bc_0", test_bc_p);
	dvv_vm::dvv_res_db<uart_bc*>::get_res_db("test_bc_1", test_bc_p);

	return 0;
}