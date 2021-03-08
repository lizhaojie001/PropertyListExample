﻿#ifndef SORT_H
#define SORT_H
#include <QObject>
#include <vector>
class Sort : public QObject
{
    Q_OBJECT
public:
    explicit Sort(QObject *parent = nullptr);
    virtual std::string getName() = 0;
private:
     std::vector<int> array;
public:
     uint64_t runCount;
     uint64_t swapCount;
     double time;
public:
     virtual void sort(std::vector<int> array) ;
     void toString();
};

#endif // SORT_H
