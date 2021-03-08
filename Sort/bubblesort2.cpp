#include "bubblesort2.h"
#include <QDebug>
BubbleSort2::BubbleSort2()
{

}
void BubbleSort2::sort(std::vector <int> array) {
    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    int last = size-1;
    for (int end = last; last >0 ;  last--) {
        for (int index = 1; index <= end ; index++) {
            if (array[index] <array[index-1]) {
                int temp = array[index];
                array[index] = array[index-1];
                array[index-1] = temp;
                last = index;
                swapCount ++;
            }
            runCount++;
        }
    }
    std::time_t t1 = std::time(0);  // t is an integer type
    int tm = t1 - t;
     this->time = tm;

}
