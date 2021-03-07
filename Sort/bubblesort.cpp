#include "bubblesort.h"
#include <vector>
#include <QDebug>
BubbleSort::BubbleSort()
{
}

void Sort:: sort(std ::vector <int>  array) {
    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    for (int end = size -1; size >0 ;  size--) {
        for (int index = 1; index <= end ; index++) {
            if (array[index] <array[index-1]) {
                int temp = array[index];
               array[index] = array[index-1];
               array[index-1] = temp;
               swapCount ++;
            }
            runCount++;
        }

    }
    std::time_t t1 = std::time(0);  // t is an integer type
    int tm = t1 - t;
     this->time = tm;
}

void BubbleSort::toString() {
    qDebug() << "\n耗时: " << this->time  << "交换次数" << this->swapCount << "循环次数" <<this->runCount;
}

