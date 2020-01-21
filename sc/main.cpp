#include <iostream>

#include "dvv_classes/dvv_res.h"
#include "dvv_classes/dvv_res_db.h"

using namespace std;
using namespace dvv_vm;

class vif {
    public:
    string name;
    int    val;
    double vald;
    vif(string name, int val, double vald){
        this->name = name;
        this->val = val;
        this->vald = vald;
    }
    void print(){
        cout << name << " " << val << " " << vald << endl;
    }
};

int main() {
    int i = 0;
    double d = 0;
    vif* vif_p;
    
    int i_0 = 70;
    int i_1 = 40;
    int i_2 = 50;
    double d_0 = 10.1;
    double d_1 = 20.2;
    double d_2 = 30.3;

    vif* vif_0 = new vif("apb",10,10.1);
    vif* vif_1 = new vif("sif",20,20.2);
    vif* vif_2 = new vif("ahb",30,30.3);

    dvv_vm::dvv_res_db<int>::set_res_db("i_0",i_0);
    dvv_vm::dvv_res_db<int>::set_res_db("i_1",i_1);
    dvv_vm::dvv_res_db<int>::set_res_db("i_2",i_2);

    dvv_vm::dvv_res_db<double>::set_res_db("d_0",d_0);
    dvv_vm::dvv_res_db<double>::set_res_db("d_1",d_1);
    dvv_vm::dvv_res_db<double>::set_res_db("d_2",d_2);

    dvv_vm::dvv_res_db<vif*>::set_res_db("vif_0",vif_0);
    dvv_vm::dvv_res_db<vif*>::set_res_db("vif_1",vif_1);
    dvv_vm::dvv_res_db<vif*>::set_res_db("vif_2",vif_2);

    dvv_vm::dvv_res_db<int>::get_res_db("i_0",i);
    cout << "i_0 = " << i << endl;
    dvv_vm::dvv_res_db<int>::get_res_db("i_1",i);
    cout << "i_1 = " << i << endl;
    dvv_vm::dvv_res_db<int>::get_res_db("i_2",i);
    cout << "i_2 = " << i << endl;

    dvv_vm::dvv_res_db<double>::get_res_db("d_0",d);
    cout << "d_0 = " << d << endl;
    dvv_vm::dvv_res_db<double>::get_res_db("d_1",d);
    cout << "d_1 = " << d << endl;
    dvv_vm::dvv_res_db<double>::get_res_db("d_2",d);
    cout << "d_2 = " << d << endl;

    dvv_vm::dvv_res_db<vif*>::get_res_db("vif_0",vif_p);
    vif_p->print();
    dvv_vm::dvv_res_db<vif*>::get_res_db("vif_1",vif_p);
    vif_p->print();
    dvv_vm::dvv_res_db<vif*>::get_res_db("vif_2",vif_p);
    vif_p->print();

    return 0;
}
