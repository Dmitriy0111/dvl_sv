/*
*  File            :   dvv_res_db.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv resource database
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_RES_DB__H
#define DVV_RES_DB__H

#include "dvv_res.h"

namespace dvv_vm {

    template <typename res_t>
    class dvv_res_db
    {
        private:
            static dvv_res<res_t>* dvv_db;
            static int size;
        public:
            static bool set_res_db(string name, const res_t& in_res);
            static bool get_res_db(string name, res_t& out_res);
    };

    template <typename res_t>
    dvv_res<res_t>* dvv_res_db<res_t>::dvv_db = new dvv_res<res_t>[0];

    template <typename res_t>
    int dvv_res_db<res_t>::size = 0;

    template <typename res_t>
    bool dvv_res_db<res_t>::set_res_db(string name, const res_t& in_res) {
        bool create_new_item = true;
        for( int i = 0 ; i < size ; i++ )
            if( dvv_db[i].get_res_name() == name ) {
                create_new_item = false;
            }
        if( size == 0 )
            create_new_item = true;

        if( !create_new_item ){
            return false;
        }
        else {
            dvv_res<res_t>* new_dvv_db = new dvv_res<res_t>[size + 1];
            for(int i = 0 ; i < size ; i++) {
                new_dvv_db[i] = dvv_db[i];
            }
            delete [] dvv_db;
            size += 1;
            dvv_db = new_dvv_db;
            dvv_db[size-1] = dvv_res<res_t>(name, in_res);
            return true;
        }
    }

    template <typename res_t>
    bool dvv_res_db<res_t>::get_res_db(string name, res_t& out_res) {
        for( int i = 0 ; i < size ; i++ ) {
            if( dvv_db[i].get_res_name() == name ) {
                out_res = *dvv_db[i].get_res_val();
                return true;
            }
        }
        return false;
    }
    
}

#endif // DVV_RES_DB__H
