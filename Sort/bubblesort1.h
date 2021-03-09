#ifndef BUBBLESORT1_H
#define BUBBLESORT1_H

#include "sort.h"

class BubbleSort1 : public Sort
{
public:
    BubbleSort1(){};
    virtual ~BubbleSort1 (){} ;
    virtual std::string getName() override {return "BubbleSort1";};



public:
    void sort(std::vector <int>&) override;
//    void toString() override;

private:
    void _Free();

private:
    int m_i;
};

#endif // BUBBLESORT1_H
