#include "bubblesort1.h"
#include <QDebug>


void BubbleSort1::sort(std::vector <int>& array) {
    this->array = &array;

    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    for (int end = size -1; end >0 ;  end--) {
        bool sort = true;
        for (int index = 1; index <= end ; index++) {
            if (array[index] <=array[index-1]) {
               swap (index ,index-1);
                sort = false;
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
    qDebug() << "\n" << array;

}
//void BubbleSort1::toString() {
//    qDebug()<<1<< "耗时: " << this->time  << "交换次数" << this->swapCount << "循环次数" <<this->runCount;
//}

