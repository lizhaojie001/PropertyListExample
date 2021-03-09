#include "selectionsort.h"
#include <QDebug>
SelectionSort::SelectionSort()
{

}


void SelectionSort::sort (std::vector <int> &array) {
    std::time_t t = std::time(0);  // t is an integer type
      runCount=0;
      swapCount = 0;
        this->array =& array;
      qDebug() << array;
          int size = array.size ();
          for (int end = size - 1 ; end > 0 ; end-- ) {
              int max = 0;
              for (int begin = 1; begin <= end ; begin++ ) {
                  if (array[begin] >= array[max]) {
                        max = begin;
                  }
                  runCount++;
              }
                  swap (max,end);

          }
          std::time_t t1 = std::time(0);  // t is an integer type
          int tm = t1 - t;
           this->time = tm;
          qDebug() << array;
}
