#include "mycallback.h"

MyCallback::MyCallback(QObject *parent) :
    Sbs2Callback(parent)
{
    QObject::connect(this,SIGNAL(spectrogramUpdated()),this,SLOT(spectrogramUpdatedSlot()));

    //Parameteres of the spectrogram
    spectrogramSamples = 128; //Window size
    spectrogramLength = 128; //FIXED to 128, indicates the sampling rate
    spectrogramDelta = 1; //Distance in samples between spectrograms

    //Example: config 128,128,1 makes a spectrogram on 128 samples every single sample
    //Example: config 128,128,16 makes a spectrogram on 128 samples every 16 samples (8 times/sec)
    //Example: config 64,128,1 makes a spectrogram on 64 samples, filling them with 0 to 128, every single sample

    turnChannelSpectrogramOn(spectrogramSamples,spectrogramLength, spectrogramDelta);
}

void MyCallback::getData(Sbs2Packet *packet)
{
    setPacket(packet);

    sbs2DataHandler->record();
    sbs2DataHandler->spectrogramChannel();
}

void MyCallback::spectrogramUpdatedSlot()
{
    qDebug() << __PRETTY_FUNCTION__;
    calculateValue();
}

void MyCallback::calculateValue()
{
    qDebug() << __PRETTY_FUNCTION__;
    qDebug() << sbs2DataHandler->getPowerValues();

    double value = 0.0;
    //Here goes the logic for calculating value from the channels spectrogram
    emit valueSignal(value);
}
