/*
*  File            :   dvv_res.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv resource
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_RES__H
#define DVV_RES__H

using namespace std;

namespace dvv_vm {

    template <typename res_t>
    class dvv_res
    {
        public:
            dvv_res(string res_name, res_t res_val);
            dvv_res();

            void set_res_val(res_t res_val);
            void set_res_name(string res_name);

            res_t* get_res_val();
            string get_res_name();
        private:
            res_t   res_val;
            string  res_name;
    };

    template <typename res_t>
    dvv_res<res_t>::dvv_res(string res_name, res_t res_val) {
        this->res_val = res_val;
        this->res_name = res_name;
    }

    template <typename res_t>
    dvv_res<res_t>::dvv_res() { }

    template <typename res_t>
    void dvv_res<res_t>::set_res_val(res_t res_val) {
        this->res_val = res_val;
    }

    template <typename res_t>
    void dvv_res<res_t>::set_res_name(string res_name) {
        this->res_name = res_name;
    }

    template <typename res_t>
    res_t* dvv_res<res_t>::get_res_val() {
        return &this->res_val;
    }

    template <typename res_t>
    string dvv_res<res_t>::get_res_name() {
        return res_name;
    }

}

#endif // DVV_RES__H
