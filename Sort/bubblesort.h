#ifndef BUBBLESORT_H
#define BUBBLESORT_H

#include "sort.h"

class BubbleSort : public Sort
{
public:
    BubbleSort();

public:
   std::string getName() override {
        return typeid (this).name();
    }
};



#endif // BUBBLESORT_H
