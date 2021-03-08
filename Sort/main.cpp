#include <QCoreApplication>
#include <QDebug>
#include <randomint.h>
#include <bubblesort.h>
#include <bubblesort1.h>
#include <bubblesort2.h>
#include "insertionsort.h"
#include "binaryserach.h"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    RandomInt rand ;
    auto  array = rand.randomInt(100,0,200);
    auto  array1 = array;
    auto  array3 = array;
    qDebug() <<array;
    BubbleSort sort;
    sort.sort(array);
    sort.toString();
    BubbleSort1 sort1;
    sort1.sort(array1);
    sort1.toString();
    //     BubbleSort2 sort2;
    //     sort2.sort(array);
    //     sort2.toString();

    InsertionSort sort3;
    sort3.sort(array3);
    sort3.toString();


    BinarySerach serach;
    qDebug() << serach.indexOf(20,array);
    qDebug() << "end";
    return a.exec();
}
