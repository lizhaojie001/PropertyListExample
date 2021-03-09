#include "bubblesort2.h"
#include <QDebug>
BubbleSort2::BubbleSort2()
{

}
void BubbleSort2::sort(std::vector <int>& array) {
    this->array = &array;
    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    for ( int end = size - 1; end >0 ;  end--) {
        int last = -1;
        for (int index = 1; index <= end ; index++) {
            if (array[index] <=array[index-1]) {
               swap (index,index-1);
                last = index;
            }
            runCount++;
        }

        end = last;
    }
    std::time_t t1 = std::time(0);  // t is an integer type
    int tm = t1 - t;
     this->time = tm;
    qDebug() << "\n" << array;

}
//void BubbleSort2::toString() {
//    qDebug()<<2<< "耗时: " << this->time  << "交换次数" << this->swapCount << "循环次数" <<this->runCount;
//}

BubbleSort2::~BubbleSort2 () {

}


