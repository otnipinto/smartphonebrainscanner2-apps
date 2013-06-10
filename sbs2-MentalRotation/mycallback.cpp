#include "mycallback.h"

MyCallback::MyCallback(int samples, int length, int delta, QObject *parent) :
    Sbs2Callback(parent)
{
    QObject::connect(sbs2DataHandler,SIGNAL(spectrogramUpdated()),this,SLOT(spectrogramUpdatedSlot()));
    //Parameteres of the spectrogram
    spectrogramSamples = samples; // Window size
    spectrogramLength = length; // FIXED to 128, indicates the sampling rate
    spectrogramDelta = delta; // Distance in samples between spectrograms

    //Example: config 128,128,1 makes a spectrogram on 128 samples every single sample
    //Example: config 128,128,16 makes a spectrogram on 128 samples every 16 samples (8 times/sec)
    //Example: config 64,128,1 makes a spectrogram on 64 samples, filling them with 0 to 128, every single sample

    turnChannelSpectrogramOn(spectrogramSamples,spectrogramLength, spectrogramDelta);
}

void MyCallback::getData(Sbs2Packet *packet)
{
    setPacket(packet);

    sbs2DataHandler->record();
    if (isRecording)
        sbs2DataHandler->spectrogramChannel();

    if (!(packet->cq == -1))
        emit cqValues(packet->cqName,packet->cq);
}

void MyCallback::spectrogramUpdatedSlot()
{
    calculateValue();
}

void MyCallback::calculateValue()
{
    int low = 10;
    int high = 12;
    double power = 1.5;

    QList<double> o1;
    QList<double> o2;

    double val;

    for (int row = 0; row < sbs2DataHandler->getPowerValues()->dim1(); ++row) {
        if (!(Sbs2Common::getChannelNames()->at(row) == "O1" || Sbs2Common::getChannelNames()->at(row) == "O2"))
            continue;

        for (int column = 0; column < sbs2DataHandler->getPowerValues()->dim2(); ++column) {
            val = (*sbs2DataHandler->getPowerValues())[row][column];

            if (column < low || column > high)
                continue;

            if (Sbs2Common::getChannelNames()->at(row) == "O1")
                o1.append((*sbs2DataHandler->getPowerValues())[row][column]);
            if (Sbs2Common::getChannelNames()->at(row) == "O2")
                o2.append((*sbs2DataHandler->getPowerValues())[row][column]);
        }
    }

    for (int i=0; i<o1.size(); ++i) {
        power += o1.at(i);
    }
    for (int i=0; i<o2.size(); ++i) {
        power += o2.at(i);
    }

    power /= (double)(o1.size()+o2.size());

    //Here goes the logic for calculating value from the channels spectrogram
    emit valueSignal(power);
}
