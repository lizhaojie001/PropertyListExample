#include "sort.h"
//#include <vector>
#include <QDebug>
#include <qdebug.h>
Sort::Sort(QObject *parent) : QObject(parent)
{



}

void Sort::toString(){


       qInfo("Items in list: %f", this->time);
    qDebug() << getName().c_str()<< "交换次数" << this->swapCount << "循环次数" <<this->runCount;

}
