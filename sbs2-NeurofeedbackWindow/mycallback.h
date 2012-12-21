#ifndef MYCALLBACK_H
#define MYCALLBACK_H

#include <sbs2callback.h>
#include <sbs2datahandler.h>

class MyCallback : public Sbs2Callback
{
    Q_OBJECT
public:
    explicit MyCallback(QObject *parent = 0);
    void getData(Sbs2Packet *packet);

signals:
    
public slots:
    void spectrogramUpdatedSlot();
};

#endif // MYCALLBACK_H
