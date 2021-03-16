#include "mergesort.h"
#include "QDebug"
MergeSort::MergeSort()
{

}

void MergeSort::sort(std::vector <int> &array) {
   devide(0,array.size());
}

void MergeSort::sort(){
    std::vector <int> a (theArray.size()>>1,0);
    qDebug() << "a" << a;
    tempArray = a;
     sort(theArray);
}



//归并排序

void MergeSort::devide(int begin , int end) {
    if (end-begin < 2) {
        return;
    }
   int mid = (end + begin) >> 1;
    devide(begin , mid);
    devide(mid,end);
    merge(begin , mid , end);
 }

void MergeSort:: merge(int begin, int mid  ,int end ) {

    int li = 0;
    int ai = begin;
    int ri = mid;
    int le = mid-begin;
    int re = end;
  qDebug() << li << ai << ri  << le  << re;
    for ( int i = 0; i < le ; i++ ) {
        tempArray[i] = theArray[begin + i];
    }
qDebug() << tempArray;
    while (li < le ) {
        if ( ri <re  && theArray[ri] < tempArray[li]) {
            theArray[ai++] = theArray[ri++];
          } else {
            theArray[ai++] = tempArray[li++];
        }
        swapCount++;
    }
}
