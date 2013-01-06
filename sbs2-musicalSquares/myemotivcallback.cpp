#include "myemotivcallback.h"


/**
  in networkHandler


    while (rawDataUdpInputSocket->hasPendingDatagrams())
    {
	    QByteArray datagram;
	    datagram.resize(rawDataUdpInputSocket->pendingDatagramSize());
	    QHostAddress sender;
	    quint16 senderPort;

	    rawDataUdpInputSocket->readDatagram(datagram.data(), datagram.size(),&sender, &senderPort);



	    int noPackets = 1;
	    int rawDataSize = 32;
	    QVector<char*>* data = new QVector<char*>;
	    for (int i= 0; i<noPackets; ++i)
	    {
		data->append(new char[rawDataSize]);
		char* buff = data->last();
		for (int k = 0; k<rawDataSize; ++k)
		{
		    buff[k] = datagram.data()[i*rawDataSize+k];
		}
	    }


	    int currentCounter = 1;
	    emit rawDataReceived(data,currentCounter);

	    return;
	}

  */

MyEmotivCallback::MyEmotivCallback(QObject *parent) :
    DtuEmotivCallback(parent)
{

    connect(dtuEmotivDataHandler,SIGNAL(spectrogramUpdated()),this,SLOT(spectrogramUpdatedSlot()));
}

void MyEmotivCallback::getData(DtuEmotivPacket *packet)
{
     thisPacket = packet;
     currentPacketCounter =  packet->counter;
     ++ currentPacket;


     qDebug() << "here";

    dtuEmotivDataHandler->setThisPacket(thisPacket);
    dtuEmotivDataHandler->record();
    if (isRecording)
	dtuEmotivDataHandler->spectrogramChannel();

    if (!(thisPacket->cq == -1))
	emit cqValues(thisPacket->cqName,thisPacket->cq);
}


void MyEmotivCallback::spectrogramUpdatedSlot()
{

    int low = 10;
    int high = 12;
    double power = 0;

    QList<double> o1;
    QList<double> o2;

    for (int row = 0; row < dtuEmotivDataHandler->getPowerValues()->dim1(); ++row)
    {
	if (!(DtuEmotivCommon::getChannelNames()->at(row) == "O1" || DtuEmotivCommon::getChannelNames()->at(row) == "O2"))
	    continue;

	for (int column = 0; column < dtuEmotivDataHandler->getPowerValues()->dim2(); ++column)
	{
	    if (column < low || column > high)
		continue;

	    if (DtuEmotivCommon::getChannelNames()->at(row) == "O1")
		o1.append((*dtuEmotivDataHandler->getPowerValues())[row][column]);
	    if (DtuEmotivCommon::getChannelNames()->at(row) == "O2")
		o2.append((*dtuEmotivDataHandler->getPowerValues())[row][column]);

	}
    }

    for (int i=0; i<o1.size(); ++i)
    {
	power += o1.at(i);
    }
    for (int i=0; i<o2.size(); ++i)
    {
	power += o2.at(i);
    }

    power /= (double)(o1.size()+o2.size());
    //insertIntoMetaFile(QString::number(power));

    emit powerValue(power);

}
