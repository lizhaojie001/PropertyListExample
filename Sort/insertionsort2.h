#ifndef INSERTIONSORT2_H
#define INSERTIONSORT2_H

#include "sort.h"

class InsertionSort2 : public Sort
{
public:
    InsertionSort2();
    ~InsertionSort2(){};
    InsertionSort2(std::vector <int> & array) : Sort(array){};

public:
    void sort(std::vector<int> &) override ;
    void sort() override;

    std::string getName() override{
        return typeid (this).name ();
    };
private:
    int serach(int,std::vector<int> &);
};

#endif // INSERTIONSORT2_H
