#include "bubblesort.h"
#include <vector>
#include <QDebug>
BubbleSort::BubbleSort()
{
}

void BubbleSort:: sort(std ::vector <int> & array) {
    this->array = &array;
    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    for (int end = size -1; size >0 ;  size--) {
        for (int index = 1; index <= end ; index++) {
            if (array[index] <array[index-1]) {
                swap (index,index-1);
             }
            runCount++;
        }

    }
    std::time_t t1 = std::time(0);  // t is an integer type
    int tm = t1 - t;
     this->time = tm;
    qDebug() << "\n" << array;

}
