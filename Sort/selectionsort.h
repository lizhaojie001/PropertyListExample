#ifndef SELECTIONSORT_H
#define SELECTIONSORT_H

#include "sort.h"

class SelectionSort : public Sort
{
public:
    SelectionSort();
    virtual ~SelectionSort(){};
    virtual std::string getName() override {return "SelectionSort";};

public:
    void sort(std::vector<int> &) override;
};

#endif // SELECTIONSORT_H
