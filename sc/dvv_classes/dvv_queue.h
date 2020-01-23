/*
*  File            :   dvv_queue.h
*  Autor           :   Vlasov D.V.
*  Data            :   2020.01.22
*  Language        :   SystemC
*  Description     :   This is dvv queue
*  Copyright(c)    :   2019 - 2020 Vlasov D.V.
*/

#ifndef DVV_QUEUE__H
#define DVV_QUEUE__H

namespace dvv_vm {

    template <typename T>
    class dvv_queue
    {
        private:
            T*   dvv_q;
            int  size;
        public:
            dvv_queue(int size = 0);

            ~dvv_queue();

            int get_size();

            bool push_back(const T& item);

            bool push_front(const T& item);

            bool pop_back(T& item);

            bool pop_front(T& item);

            T operator[](const int index);
    };

    template <typename T>
    dvv_queue<T>::dvv_queue(int size = 0) {
        this->size = size;
        dvv_q = new T[size];
    }

    template <typename T>
    dvv_queue<T>::~dvv_queue() {
        delete [] dvv_q;
    }

    template <typename T>
    int dvv_queue<T>::get_size() {
        return size;
    }

    template <typename T>
    bool dvv_queue<T>::push_back(const T& item) {
        T* new_dvv_q; 
        new_dvv_q = new T[size + 1];
        for(int i = 0 ; i < size ; i++) {
            new_dvv_q[i] = dvv_q[i];
        }
        delete [] dvv_q;
        dvv_q = new_dvv_q;
        dvv_q[size] = item;
        size += 1;
        return true;
    }

    template <typename T>
    bool dvv_queue<T>::push_front(const T& item) {
        T* new_dvv_q = new T[size + 1];
        for (int i = 0; i < size; i++) {
            new_dvv_q[i+1] = dvv_q[i];
        }
        delete[] dvv_q;
        dvv_q = new_dvv_q;
        dvv_q[0] = item;
        size += 1;
        return true;
    }

    template <typename T>
    bool dvv_queue<T>::pop_back(T& item) {
        item = dvv_q[size-1];
        T* new_dvv_q = new T[size - 1];
        for (int i = 0; i < size - 1; i++) {
            new_dvv_q[i] = dvv_q[i];
        }
        delete[] dvv_q;
        dvv_q = new_dvv_q;
        size -= 1;
        return true;
    }

    template <typename T>
    bool dvv_queue<T>::pop_front(T& item) {
        item = dvv_q[0];
        T* new_dvv_q = new T[size - 1];
        for (int i = 0; i < size - 1 ; i++) {
            new_dvv_q[i] = dvv_q[i+1];
        }
        delete[] dvv_q;
        dvv_q = new_dvv_q;
        size -= 1;
        return true;
    }

    template <typename T>
    T dvv_queue<T>::operator[](const int index) {
        assert((index < size) && (index >= 0));
        return dvv_q[index];
    }
    
}

#endif // DVV_QUEUE__H
