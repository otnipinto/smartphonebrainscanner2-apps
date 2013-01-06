#ifndef MYEMOTIVCALLBACK_H
#define MYEMOTIVCALLBACK_H

#include <dtuemotivcallback.h>
#include <dtuemotivdatahandler.h>

class MyEmotivCallback : public DtuEmotivCallback
{
    Q_OBJECT
public:
    explicit MyEmotivCallback(QObject *parent = 0);
    void getData(DtuEmotivPacket *packet);

signals:
    void powerValue(QVariant value);

public slots:
    void spectrogramUpdatedSlot();
    
};

#endif // MYEMOTIVCALLBACK_H
