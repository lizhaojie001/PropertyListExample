#include "insertionsort2.h"
#include <QDebug>
InsertionSort2::InsertionSort2()
{

}
/*
  * author : YanQing
  * method: 优化插入排序
  * params : 仅仅优化了插入位置查找,未改变复杂度,依旧是o(n^2)
  * @return : .........
  */
void InsertionSort2::sort(std::vector<int> & array) {
    for (int begin = 1; begin < array.size() ; begin++ ) {
        int value = array[begin];
        int cur = begin;
        int index = serach (cur,array);
        for (; cur > index ; cur-- ) {
            array[cur] = array[cur-1];
            runCount++;
            swapCount++;
        }
        array[index] = value;
    }
    qDebug() << array;
}



/*
  * author : YanQing
  * method: 优化插入排序
  * params : ..........
  * @return : .........
  */

int InsertionSort2 ::serach(int index , std::vector <int> & array) {
    int value = array[index];
    int begin = 0;
    int end = index;
      while (begin < end  ) {
        int mid = (end+begin)>>1;
         if (value >=array[mid]) {
                begin = mid + 1;
         } else if( value < array[mid]){
                end = mid;
         }
     }

      return begin;
}
