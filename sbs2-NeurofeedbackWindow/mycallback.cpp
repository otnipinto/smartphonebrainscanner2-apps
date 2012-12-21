#include "mycallback.h"

MyCallback::MyCallback(QObject *parent) :
    Sbs2Callback(parent)
{
    QObject::connect(this,SIGNAL(spectrogramUpdated()),this,SLOT(spectrogramUpdatedSlot()));
    turnChannelSpectrogramOn();
}

void MyCallback::getData(Sbs2Packet *packet)
{
    setPacket(packet);

    sbs2DataHandler->record();
    sbs2DataHandler->spectrogramChannel();
}

void MyCallback::spectrogramUpdatedSlot()
{
    qDebug() << sbs2DataHandler->getPowerValues();
}
