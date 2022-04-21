#ifndef AUDIOTHREAD_H
#define AUDIOTHREAD_H

#include <QThread>

class AudioThread : public QThread
{
public:
    AudioThread();
 void   run() override;
};

#endif // AUDIOTHREAD_H
