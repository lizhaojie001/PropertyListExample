#include <QCoreApplication>
#include <QDebug>
#include <randomint.h>
#include <bubblesort.h>
#include <bubblesort1.h>
#include <bubblesort2.h>
 #include "selectionsort.h"
#include "insertionsort.h"
#include "binaryserach.h"
#include "insertionsort2.h"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
     RandomInt rand ;
     std::vector<int>  array =  rand.randomInt(102,0,200);
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

     auto array4 = array;
     array4.assign (array.begin (), array.end ());

     auto array5 = array;
     array5.assign (array.begin (), array.end ());

     BubbleSort * sort = new BubbleSort(array);
     sort->sort ();
     BubbleSort1* sort1 = new BubbleSort1(array1);
     sort1->sort ();
     sort1->toString ();
     BubbleSort2 * sort2 = new BubbleSort2(array2);
    sort2->sort ();
    sort2->toString ();

    SelectionSort *sort3 = new SelectionSort(array3);
   sort3->sort ();
   sort3->toString ();

   InsertionSort * sort4 = new InsertionSort(array4);
   sort4->sort ();
   sort4->toString ();

   BinarySerach serach;
   int index = serach.indexOf (20,array4);
   qInfo("索引: %d",index);

   InsertionSort2 * sort5  = new InsertionSort2(array5);
    sort5->sort ();
    sort5->toString ();

    qDebug() << "exe.end";
    return a.exec();
}
