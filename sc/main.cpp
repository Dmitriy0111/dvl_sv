#include "systemc.h"

#include "dvv_vm_pkg.h"
#include "dvv_macro.h"

using namespace std;
using namespace dvv_vm;

class trans {
    public:
        int data;
        int addr;
        int we_re;

        void print() {
            cout << "Addr = " << addr << endl
                 << "Data = " << data << endl
                 << "We_re = " << we_re << endl;
        };
};

class sif_drv : public dvv_drv<trans> {
    public:
        OBJ_BEGIN(sif_drv)
        explicit sif_drv(sc_module_name name) : dvv_drv(name) { };
        sif_drv() : dvv_drv() { };
};

class sif_mon : public dvv_mon<trans> {
    public:
        OBJ_BEGIN(sif_mon)

        explicit sif_mon(sc_module_name name) : dvv_mon(name) { 
            mon_aep = new dvv_aep<trans>("mon_aep");
        };

        sif_mon() : dvv_mon() { };
};

class sif_cov : public dvv_scr<trans> {
    public:
        typedef dvv_scr<trans> base_type;

        OBJ_BEGIN(sif_cov)
        explicit sif_cov(sc_module_name name) : dvv_scr(name) { 
            item_ap = new dvv_ap<trans,base_type>(this,"cov_ap");
        };
        sif_cov() : dvv_scr() { };

        void write(trans item) {
            item.print();
        }
};

class tr_gen : public dvv_gen<trans> {
    public:
        OBJ_BEGIN(tr_gen)


        explicit tr_gen(sc_module_name name) : dvv_gen(name) { }
        tr_gen() : dvv_gen() { };

        void run() {
            cout << this->c_fname << endl;
            //sc_core::wait(10.0, sc_core::SC_US); // 10us;
        }
};

class sif_agt : public dvv_agt {
    public:
        OBJ_BEGIN(sif_agt)

        sif_drv*   drv;
        sif_mon*   mon;
        sif_cov*   cov;

        explicit sif_agt(sc_module_name name) : dvv_agt(name) { };
        sif_agt() : dvv_agt() { };

        void build() {
            drv = sif_drv::create::create_obj("drv",this);
            mon = sif_mon::create::create_obj("mon",this);
            cov = sif_cov::create::create_obj("cov",this);
        }

        void connect() {
            mon->mon_aep->connect(cov->item_ap);
        }
};

class sif_env : public dvv_env {
    public:
        OBJ_BEGIN(sif_env)

        sif_agt*   agt;

        tr_gen*     gen;

        explicit sif_env(sc_module_name name) : dvv_env(name) { };

        sif_env() : dvv_env() { };

        void build() {
            agt = sif_agt::create::create_obj("agt",this);
            gen = tr_gen::create::create_obj("gen",this);
        }
        
        void connect() {
        }
};

class sif_test : public dvv_test {
    public:
        OBJ_BEGIN(sif_test)
        
        sif_env*   env;

        explicit sif_test(sc_module_name name) : dvv_test(name) { };

        sif_test() : dvv_test() { };

        void build() {
            env = sif_env::create::create_obj("env", this);
        };
};

SC_MODULE(dut) { 
    sc_in<sc_int<32>>      addr;
    sc_in<sc_int<32>>      data;
    sc_in<sc_int<1>>      we_re;
    sc_in<bool>             clk;

    SC_CTOR(dut) {
      SC_METHOD(run);
      sensitive_pos(clk);
    }

    void run() {
        cout << addr << " " << data << " " << we_re << endl;
    };
};

SC_MODULE(drv) {
    sc_out<sc_int<32>>      addr;
    sc_out<sc_int<32>>      data;
    sc_out<sc_int<1>>       we_re;
    sc_in<bool>             clk;

    SC_CTOR(drv) {
        SC_METHOD(run);
        sensitive_pos(clk);
    }

    void run() {
        data = rand();
        addr = rand();
        we_re = rand();
    };
};

int sc_main(int, char **)
{
    sc_time clock_length(10, SC_NS);
    sc_clock clock ("clk",1,0.5);

    sc_signal<sc_int<1>> we_re;
    sc_signal<sc_int<32>> data;
    sc_signal<sc_int<32>> addr;

    //sif_test* test = new sif_test("test");
    //trans* tr = new trans();
    dut* dut_p = new dut("dut_p");
    drv* drv_p = new drv("drv_p");

    dut_p->clk(clock);
    dut_p->data(data);
    dut_p->addr(addr);
    dut_p->we_re(we_re);

    drv_p->clk(clock);
    drv_p->data(data);
    drv_p->addr(addr);
    drv_p->we_re(we_re);

    sc_trace_file *tf = sc_create_vcd_trace_file("tf");
    sc_trace(tf, clock, "clk");
    sc_trace(tf, addr, "addr");
    sc_trace(tf, data, "data");
    sc_trace(tf, we_re, "we_re");
    
    //tr->data = 10;
    //tr->addr = 20;
    //tr->we_re = 30;

    //test->test_start();
    //test->print_map();

    sc_start();

    //test->env->agt->mon->mon_aep->write(*tr);

    sc_close_vcd_trace_file(tf);

    return 0;
}