#ifndef QUICKSORT_H
#define QUICKSORT_H

#include "sort.h"

class QuickSort : public Sort
{
public:
    QuickSort();
    ~QuickSort(){};
    using Sort::Sort;
public:
    virtual  std::string getName() override{
         return typeid (this).name();
    }
    void sort() override;
    void sort(std::vector<int> &) override;
private:
    int povit(int,int);
    void resort(int , int);

};

#endif // QUICKSORT_H
