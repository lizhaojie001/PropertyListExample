#ifndef SORT_H
#define SORT_H
#include <QObject>
#include <vector>
class Sort : public QObject
{
    Q_OBJECT

public:
    explicit Sort(QObject *parent = nullptr);
    virtual std::string getName() = 0;
public:
     uint64_t runCount = 0;
     uint64_t swapCount = 0;
     double time = 0;
protected:
     std::vector<int> *array;
     virtual void sort(std::vector<int> &) = 0;
     void swap(int a , int b )    ;
public:
     void toString();
};

#endif // SORT_H
