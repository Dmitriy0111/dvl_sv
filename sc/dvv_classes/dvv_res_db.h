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

namespace dvv_vm {

    template <typename res_t>
    class dvv_res_db
    {
        private:
            static dvv_queue<dvv_res<res_t>>    dvv_db;
        public:
            static bool set_res_db(string name, const res_t& in_res);
            static bool get_res_db(string name, res_t& out_res);
    };

    template <typename res_t>
    dvv_queue<dvv_res<res_t>> dvv_res_db<res_t>::dvv_db = dvv_queue<dvv_res<res_t>>(0);

    template <typename res_t>
    bool dvv_res_db<res_t>::set_res_db(string name, const res_t& in_res) {
        bool create_new_item = true;
        for( int i = 0 ; i < dvv_db.get_size() ; i++ )
            if( dvv_db[i].get_res_name() == name ) {
                create_new_item = false;
            }
        if( dvv_db.get_size() == 0 )
            create_new_item = true;

        if( !create_new_item ){
            return false;
        }
        else {
            dvv_db.push_back(dvv_res<res_t>(name, in_res));
            return true;
        }
    }

    template <typename res_t>
    bool dvv_res_db<res_t>::get_res_db(string name, res_t& out_res) {
        for( int i = 0 ; i < dvv_db.get_size(); i++ ) {
            if( dvv_db[i].get_res_name() == name ) {
                out_res = *dvv_db[i].get_res_val();
                return true;
            }
        }
        return false;
    }
    
}

#endif // DVV_RES_DB__H
