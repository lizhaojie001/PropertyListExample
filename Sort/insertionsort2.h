#ifndef INSERTIONSORT2_H
#define INSERTIONSORT2_H

#include "sort.h"

class InsertionSort2 : public Sort
{
public:
    InsertionSort2();
    ~InsertionSort2(){};

public:
    void sort(std::vector<int> &) override ;
    std::string getName() override{
        return typeid (this).name ();
    };
private:
    int serach(int,std::vector<int> &);
};

#endif // INSERTIONSORT2_H
