#ifndef RANDOMINT_H
#define RANDOMINT_H
#include<vector>
#include <QObject>

class RandomInt : public QObject
{
    Q_OBJECT
public:
    explicit RandomInt(QObject *parent = nullptr);
    std::vector <int> randomInt(int  num = 10, int start = 0,int  end  = 100);
signals:

};

#endif // RANDOMINT_H
