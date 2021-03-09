#ifndef BUBBLESORT2_H
#define BUBBLESORT2_H

#include "sort.h"

class BubbleSort2 : public Sort
{
public:
    BubbleSort2();
    virtual ~BubbleSort2 () ;
    virtual std::string getName() override {return "BubbleSort2";};

public:
    void sort(std::vector <int> &) override;
//    void toString() override;

};

#endif // BUBBLESORT2_H
