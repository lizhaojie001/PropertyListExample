#ifndef QUICKSORT_H
#define QUICKSORT_H

#include "sort.h"

class QuickSort : public Sort
{
public:
    QuickSort();
     ~QuickSort();

    using Sort::Sort;
public:
    virtual  std::string getName() override{
         return typeid (this).name();
    }
protected:
    virtual void sort(std::vector<int> &) override{};
    virtual void sort() override{};
private:
    int povit(int,int){return 0;};
    void resort(int , int){};

};

#endif // QUICKSORT_H
