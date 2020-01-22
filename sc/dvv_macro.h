/*
*  File            :   dvv_macro.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.21
*  Language        :   SystemC
*  Description     :   This is dvv macroses
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_MACRO__H
#define DVV_MACRO__H

#define OBJ_BEGIN(...) \
    typedef dvv_cc<__VA_ARGS__> create; \

#endif // DVV_MACRO__H
