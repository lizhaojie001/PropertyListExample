#include "binaryserach.h"
#include <QDebug>
BinarySerach::BinarySerach(QObject *parent) : QObject(parent)
{

}
//二分查找
 int BinarySerach::indexOf(int value , std::vector <int> &array) {
      int size = array.size();
      int begin = 0;
      int end = size;
        while (begin < end  ) {
          int mid = (end+begin)>>1;
          qDebug() << begin << mid << end;
           if (value >array[mid]) {
                  begin = mid + 1;
           } else if( value < array[mid]){
                  end = mid;
           } else {
               return mid;
           }
       }


       return -1;

}
