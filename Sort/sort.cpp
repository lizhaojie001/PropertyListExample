#include "sort.h"
//#include <vector>
#include <QDebug>
 using namespace std;

Sort::Sort(QObject *parent) : QObject(parent)
{

}

void Sort::toString() {
     qDebug() << getName().c_str ()<< "耗时: " << this->time  << "交换次数" << this->swapCount << "循环次数" <<this->runCount <<"\n";
}




void Sort::swap(int a, int b) {
      int temp = (*array)[a];
       (*array)[a] = (*array)[b];
      (*array)[b] = temp;
      swapCount++;

}
