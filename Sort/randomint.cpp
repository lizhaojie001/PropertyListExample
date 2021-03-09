#include "randomint.h"
#include <time.h>
RandomInt::RandomInt(QObject *parent) : QObject(parent)
{

}

std::vector <int>RandomInt::randomInt(int num , int start , int end) {
      std::vector <int > array ;
      srand((unsigned)time(NULL));
      for (int i = 0; i < num ; i++ ) {
          int a  = arc4random ()%(end-start) + start;
          array.push_back(a);
      }
      return array;
}
