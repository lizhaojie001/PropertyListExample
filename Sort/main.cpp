#include <QCoreApplication>
#include <QDebug>
#include <randomint.h>
#include <bubblesort.h>
#include <bubblesort1.h>
#include <bubblesort2.h>
#include "selectionsort.h"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
     RandomInt rand ;
     std::vector<int>  array =  rand.randomInt(100,0,200);
     array.push_back (2001);
     array.push_back (2002);
     array.push_back (2003);
     array.push_back (2004);
     array.push_back (2005);
     array.push_back (2006);
     array.push_back (2007);
     array.push_back (2008);

      std::vector<int>  array1;
      array1.assign (array.begin (), array.end ());
     auto array2 = array;
     array2.assign (array.begin (), array.end ());
     auto array3 = array;
     array3.assign (array.begin (), array.end ());
    qDebug() << array << array1 << array2 << "\n";

     BubbleSort sort;
     sort.sort(array);
     sort.toString();
     BubbleSort1 sort1;
     sort1.sort(array1);
     sort1.toString();
     BubbleSort2 sort2;
    sort2.sort(array2);
    sort2.toString();

    SelectionSort sort3;
   sort3.sort(array2);
   sort3.toString();

    return a.exec();
}
