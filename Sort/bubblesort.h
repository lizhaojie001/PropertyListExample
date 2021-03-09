#ifndef BUBBLESORT_H
#define BUBBLESORT_H

#include "sort.h"

class BubbleSort : public Sort
{
public:
    BubbleSort();
    virtual ~BubbleSort() ;
    virtual std::string getName() override {return "BubbleSort";};
    public:
    void sort(std::vector <int>&) override;
//    void toString() override;
};



#endif // BUBBLESORT_H
