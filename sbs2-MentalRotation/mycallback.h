#ifndef MYCALLBACK_H
#define MYCALLBACK_H

#include <sbs2callback.h>
#include <sbs2datahandler.h>

class MyCallback : public Sbs2Callback
{
    Q_OBJECT
public:
    explicit MyCallback(int samples, int length, int delta, QObject *parent = 0);
    void getData(Sbs2Packet *packet);

private:
    void calculateValue();

private:
    int spectrogramSamples;
    int spectrogramLength;
    int spectrogramDelta;

signals:
    void valueSignal(QVariant value);

public slots:
    void spectrogramUpdatedSlot();
};

#endif // MYCALLBACK_H
