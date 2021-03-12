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
    InsertionSort(std::vector <int> & array) : Sort(array){};

public:
    void sort(std::vector<int> &array) override ;
    void sort() override;

    std::string getName() override {
         return typeid (this).name();
     }
};

#endif // INSERTIONSORT_H
