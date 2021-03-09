#ifndef BINARYSERACH_H
#define BINARYSERACH_H

#include <QObject>
using namespace std;
class BinarySerach : public QObject
{
    Q_OBJECT
public:
    explicit BinarySerach(QObject *parent = nullptr);


public:
   int indexOf(int value,std::vector<int> &);
signals:

};

#endif // BINARYSERACH_H
