#ifndef BUBBLESORT2_H
#define BUBBLESORT2_H

#include "sort.h"

class BubbleSort2 : public Sort
{
public:
    BubbleSort2();
    void sort(std::vector <int>) override;
    std::string getName() override {
         return typeid (this).name();
     }

};

#endif // BUBBLESORT2_H
