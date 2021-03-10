#ifndef INSERTIONSORT_H
#define INSERTIONSORT_H
#include "sort_template.h"
#include "sort.h"
#include <QDebug>
class InsertionSort : public Sort
{




public:
    InsertionSort();
    ~InsertionSort(){};
    void sort(std::vector<int> &array) override ;

    std::string getName() override {
         return typeid (this).name();
     }
};

#endif // INSERTIONSORT_H
