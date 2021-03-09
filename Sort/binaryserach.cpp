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
        while (begin < end ) {
          int mid = (end+begin) >>1+ 1;
           if (value >= array[mid]) {
                  begin = mid;
           } else {
                  end = mid;
           }
       }
       if (value == array[begin]) {
           return begin;
       }

       return -1;

}
