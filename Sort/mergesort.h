#ifndef MERGESORT_H
#define MERGESORT_H

#include "sort.h"
#include <vector>
class MergeSort : public Sort
{
public:
    MergeSort();
    using  Sort::Sort ;
    std::string getName() override{
        return typeid (this).name ();
    };
    public:
   void  sort() override;
   void sort(std::vector<int> &) override;
private:
  void  devide(int , int);
  void merge(int ,int, int);
private:
   std::vector <int > tempArray;
};

#endif // MERGESORT_H
