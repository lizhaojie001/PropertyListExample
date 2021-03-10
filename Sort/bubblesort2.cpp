#include "bubblesort2.h"
#include <QDebug>
#include "sort_template.h"
BubbleSort2::BubbleSort2()
{

}
void BubbleSort2::sort(std::vector <int>& array) {
    std::time_t t = std::time(0);  // t is an integer type
    int size = array.size();
    for ( int end = size - 1; end >0 ;  end--) {
        int last = -1;
        for (int index = 1; index <= end ; index++) {
            if (array[index] <=array[index-1]) {
               Swap (array[index],array[ index-1]);
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

