#ifndef INSERTIONSORT_H
#define INSERTIONSORT_H

#include "sort.h"
#include <QDebug>
class InsertionSort : public Sort
{


private:
int compare(int a , int b ) {
    return a - b;
}
void swap(int index1, int index2 , std::vector <int> &array){
                    int temp = array[index1];
                    array[index1] = array[index2];
                    array[index2] = temp;
                    swapCount++;
 }



public:
    InsertionSort();
    void sort(std::vector<int> array) override {
        runCount =0;
        swapCount = 0;
        int size = array.size();
        for (int begin = 0; begin < size ; begin++ ) {
            int value = array[begin];
             while  (begin > 0 && (compare(array[begin] ,array[begin-1] ) < 0))
            {
                         swap(begin,begin-1,array);
                         begin = begin-1;
                         runCount++;
            }
            array[begin] = value;
        }
        qDebug() <<array;
    }
    std::string getName() override {
         return typeid (this).name();
     }
};

#endif // INSERTIONSORT_H
