#ifndef BUBBLESORT1_H
#define BUBBLESORT1_H

#include "sort.h"

class BubbleSort1 : public Sort
{
public:
    BubbleSort1();
    void sort(std::vector <int>) override;
    void toString() override;
};

#endif // BUBBLESORT1_H
