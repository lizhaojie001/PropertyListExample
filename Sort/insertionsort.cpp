#include "insertionsort.h"

InsertionSort::InsertionSort()
{

}

int compare(int a , int b ) {
    return a - b;
}

void InsertionSort::sort(std::vector<int> &array)
{
    runCount =0;
    swapCount = 0;
    int size = array.size();
    for (int begin = 0; begin < size ; begin++ ) {
        int value = array[begin];
         while  (begin > 0 && (compare(array[begin] ,array[begin-1] ) < 0))
        {

                     Swap (array[begin],array[begin-1]);
                     begin = begin-1;
                     runCount++;
        }
        array[begin] = value;
    }
    qDebug() <<array;
}


void InsertionSort::sort(){
    sort(theArray);
}
