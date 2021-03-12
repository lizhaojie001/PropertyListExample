#ifndef BUBBLESORT_H
#define BUBBLESORT_H

#include "sort.h"
#include <vector>
class BubbleSort : public Sort
{
public:
    BubbleSort();
    BubbleSort(std::vector <int> & array) : Sort(array){};
    virtual ~BubbleSort(){} ;
    virtual std::string getName() override {return "BubbleSort";};
    public:
    void sort(std::vector <int>&) override;
    void sort() override ;
};



#endif // BUBBLESORT_H
