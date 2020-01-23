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

    typedef uart_bc this_type;

    dvv_ap<int,uart_bc>*    uart_ap;

    explicit uart_bc(sc_module_name name) : dvv_bc(name) { 
        uart_ap = new dvv_ap<int,this_type>(this);
    };

    void write(int item) {
        cout << "Rec item " + this->c_fname + " " << item << endl;
    };

    uart_bc() { };
};

dvv_ap_decl(_oth_1)
dvv_ap_decl(_oth_2)

class example : public dvv_scr<int> {
    public:
        OBJ_BEGIN(example)

        typedef dvv_scr<int> base_type;
        typedef example this_type;

        int     item_0;
        int     item_1;
        int     item_2;

        dvv_ap_oth_1<int,this_type>*    ex_ap_1;
        dvv_ap_oth_2<int,this_type>*    ex_ap_2;

        explicit example(sc_module_name name) : dvv_scr<int>(name) { 
            item_ap = new dvv_ap<int,base_type>(this);
            ex_ap_1 = new dvv_ap_oth_1<int,this_type>(this);
            ex_ap_2 = new dvv_ap_oth_2<int,this_type>(this);
        };

        example() { };

        void write(int item) {
            item_0 = item;
            cout << "Rec item " + this->c_fname + " " << item_0 << endl;
        };

        void write_oth_1(int item) {
            item_1 = item;
            cout << "Rec item " + this->c_fname + " " << item_1 << endl;
        };

        void write_oth_2(int item) {
            item_2 = item;
            cout << "Rec item " + this->c_fname + " " << item_2 << endl;
        };
};

dvv_ap_decl(_0)
class uart_scr : public dvv_scr<int> {
    public:
        OBJ_BEGIN(uart_scr)

        typedef dvv_scr<int> base_type;
        typedef uart_scr this_type;

        dvv_ap_0<int,this_type>* ap_0;

        explicit uart_scr(sc_module_name name) : dvv_scr<int>(name) { 
            item_ap = new dvv_ap<int,base_type>(this);
            ap_0 = new dvv_ap_0<int,this_type>(this);
        };

        uart_scr() { };

        void write(int item) {
            cout << "Rec item " + this->c_fname + " " << item << endl;
        };

        void write_0(int item) {
            cout << "Rec item " + this->c_fname + " " << item << endl;
        };
};

class uart_agt : public dvv_agt {
    public:
        OBJ_BEGIN(uart_agt)

        dvv_aep<int>*   agt_aep;

        explicit uart_agt(sc_module_name name) : dvv_agt(name) { 
            agt_aep = new dvv_aep<int>();
        };

        uart_agt() : dvv_agt() { };
};

class uart_env : public dvv_env {
    public:
        OBJ_BEGIN(uart_env)

        uart_agt*   agt;

        uart_bc*    ubc_0;
        uart_bc*    ubc_1;

        uart_scr*   scr;

        example*    ex;

        explicit uart_env(sc_module_name name) : dvv_env(name) { };

        uart_env() : dvv_env() { };

        void build() {
            agt = uart_agt::create::create_obj("agt",this);
            ubc_0 = uart_bc::create::create_obj("ubc_0",this);
            ubc_1 = uart_bc::create::create_obj("ubc_1",this);
            scr = uart_scr::create::create_obj("scr",this);
            ex = example::create::create_obj("ex",this);
        }
        
        void connect() {
            agt->agt_aep->connect(ubc_0->uart_ap);
            agt->agt_aep->connect(ubc_1->uart_ap);
            agt->agt_aep->connect(scr->item_ap);
            agt->agt_aep->connect(scr->ap_0);
            agt->agt_aep->connect(ex->item_ap);
            agt->agt_aep->connect(ex->ex_ap_1);
            agt->agt_aep->connect(ex->ex_ap_2);
        }
};

class uart_test : public dvv_test {
    public:
        OBJ_BEGIN(uart_test)
        
        uart_env*   env;

        explicit uart_test(sc_module_name name) : dvv_test(name) { };

        uart_test() : dvv_test() { };

        void build() {
            env = uart_env::create::create_obj("env", this);
        };
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

    uart_bc* test_child_0;
    uart_bc* test_child_1;
    uart_bc* test_child_2;
    uart_bc* test_child_00;
    uart_bc* test_child_10;
    uart_bc* test_child_11;
    uart_bc* test_child_12;
    uart_bc* test_child_20;
    uart_bc* test_child_21;
    uart_bc* test_child_22;

    uart_agt* test_agt_0;
    uart_agt* test_agt_1;
    uart_env* test_env_0;

    uart_test* test = new uart_test("test");

    test_env_0 = uart_env::create::create_obj("test_env_0", test_bc);
    test_env_0->build();
    test_env_0->connect();

    test_env_0->agt->agt_aep->write(10);
    test_env_0->agt->agt_aep->write(20);
    test_env_0->agt->agt_aep->write(30);

    test_agt_0 = uart_agt::create::create_obj("test_agt_0", test_bc);
    test_agt_1 = uart_agt::create::create_obj("test_agt_1", test_bc);

    test_child_0 = uart_bc::create::create_obj("test_child_0", test_agt_0);
    test_child_1 = uart_bc::create::create_obj("test_child_1", test_agt_1);
    test_child_2 = uart_bc::create::create_obj("test_child_2", test_agt_1);
    test_child_00 = uart_bc::create::create_obj("test_child_00", test_child_0);
    test_child_10 = uart_bc::create::create_obj("test_child_10", test_child_1);
    test_child_11 = uart_bc::create::create_obj("test_child_11", test_child_1);
    test_child_12 = uart_bc::create::create_obj("test_child_12", test_child_1);
    test_child_20 = uart_bc::create::create_obj("test_child_20", test_child_2);
    test_child_21 = uart_bc::create::create_obj("test_child_21", test_child_2);
    test_child_22 = uart_bc::create::create_obj("test_child_22", test_child_2);

    test_bc->print_map();

    test->test_start();

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

    return 0;
}