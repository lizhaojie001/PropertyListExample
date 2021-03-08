#include "bubblesort1.h"
#include <QDebug>
BubbleSort1::BubbleSort1()
{

}

void BubbleSort1::sort(std::vector <int> array) {
    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    for (int end = size -1; size >0 ;  size--) {
        bool sort = true;
        for (int index = 1; index <= end ; index++) {
            if (array[index] <array[index-1]) {
                int temp = array[index];
                array[index] = array[index-1];
                array[index-1] = temp;
                sort = false;
                swapCount ++;
            }
            runCount ++;
        }
        if (sort) {
            break;
        }
    }
    std::time_t t1 = std::time(0);  // t is an integer type
    int tm = t1 - t;
     this->time = tm;

}

