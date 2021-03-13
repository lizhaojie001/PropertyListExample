#include "sort.h"
//#include <vector>
#include <QDebug>
 using namespace std;

Sort::Sort(QObject *parent) : QObject(parent)
{

}

Sort::Sort(std::vector<int> &array) :theArray(array) {
    qDebug() << "初始化数组" << theArray;
}

void Sort::toString() {
    qDebug() << "排序后数组  " << theArray;
     qDebug() << getName().c_str ()<< "耗时: " << this->time  << "交换次数" << this->swapCount << "循环次数" <<this->runCount <<"\n";
}

void Sort::sort(){
            sort(theArray);
}



//void Sort::swap(int a, int b) {
//      int temp = (*array)[a];
//       (*array)[a] = (*array)[b];
//      (*array)[b] = temp;
//      swapCount++;

//}
