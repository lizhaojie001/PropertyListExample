#include "quicksort.h"

QuickSort::QuickSort()
{

}


//void QuickSort::sort(std::vector <int> & array) {
//    resort(0,array.size());
//}


//void QuickSort::sort() {
//    sort(theArray);
//}


//void QuickSort::resort(int begin , int end) {
//    int mid =  povit(begin,end);
//    resort(begin,mid);
//    resort(mid+1,end);
//}



////找轴点
//int QuickSort::povit(int begin , int end) {
//    end--;
//    int povit = theArray[begin];
//    while (begin <end) {
//        while (begin <end) {
//            if (theArray[end] > theArray[begin]) {
//                end--;
//            } else {
//                theArray[begin++] = theArray[end];
//                break;
//            }
//        }
//        while (begin <end) {
//            if (theArray[begin] > povit) {
//                theArray[end++] = theArray[begin];
//                break;
//            } else {
//                begin++;
//            }
//        }
//    }

//   theArray[begin] = povit;
//    return begin;
//}

