#ifndef BUBBLESORT2_H
#define BUBBLESORT2_H

#include "sort.h"

class BubbleSort2 : public Sort
{
public:
    BubbleSort2();
    virtual ~BubbleSort2 () {};
    virtual std::string getName() override {return "BubbleSort2";};
    BubbleSort2(std::vector <int> & array) : Sort(array){};

public:
    void sort(std::vector <int> &) override;
    void sort() override;
};

#endif // BUBBLESORT2_H
