#include "quicksort.h"
#include <time.h>
#include <sort_template.h>

QuickSort::QuickSort()
{

}


void QuickSort::sort(std::vector <int> & array) {
    resort(0,array.size());
}


void QuickSort::sort() {
    sort(theArray);
}


void QuickSort::resort(int begin , int end) {
    if (end - begin < 2) {
        return ;
    }
    int mid =  povit(begin,end);
    resort(begin,mid);
    resort(mid+1,end);
}



////找轴点
int QuickSort::povit(int begin , int end) {
    end--;
    int povit = theArray[begin];
    //防止数组为有序数组影响轴点的选取,轴点随机取位置
    int index = arc4random ()%(end-begin) + begin;
    Swap(theArray[index] , theArray[begin]);
    while (begin <end) {
        while (begin <end) {
            if (theArray[end] > povit) {
                end--;
            } else {
                theArray[begin++] = theArray[end];
                swapCount++;
                break;
            }
            runCount++;
        }
        while (begin <end) {
            if (theArray[begin] > povit) {
                theArray[end--] = theArray[begin];
                swapCount++;
                break;
            } else {
                begin++;
            }
            runCount++;
        }
    }

   theArray[begin] = povit;
    return begin;
}

