#ifndef BUBBLESORT1_H
#define BUBBLESORT1_H

#include "sort.h"

class BubbleSort1 : public Sort
{
public:
    BubbleSort1();
    void sort(std::vector <int>) override;
    std::string getName() override {
         return typeid (this).name();
     }
};

#endif // BUBBLESORT1_H
