#include "networkhandler.h"
#include <QDebug>

NetworkHandler::NetworkHandler(): QObject()
{
   inPort = 7777;
   outPort = 6666;

   udpSocketInInit();
   //udpSocketOutInit();

}

void NetworkHandler::udpSocketInInit()
{
    udpSocketIn = new QUdpSocket(this);
    udpSocketIn->bind(QHostAddress("127.0.0.1"), inPort);

    qDebug() << "void NetworkHandler::udpSocketInInit() 2";
    connect(udpSocketIn, SIGNAL(readyRead()), this, SLOT(readPendingDatagrams()));

}

void NetworkHandler::udpSocketOutInit()
{
    udpSocketOut = new QUdpSocket(this);
}

void NetworkHandler::readPendingDatagrams()
{


    while (udpSocketIn->hasPendingDatagrams())
    {
	    QByteArray datagram;
	    datagram.resize(udpSocketIn->pendingDatagramSize());
	    QHostAddress sender;
	    quint16 senderPort;

	    udpSocketIn->readDatagram(datagram.data(), datagram.size(),
				    &sender, &senderPort);



	    emit dataReceived(datagram.data());

	}
}


void NetworkHandler::writeData(QString data)
{
    dataArray.clear();
    dataArray.append(data);
    udpSocketOut->writeDatagram(dataArray,QHostAddress("127.0.0.1"), outPort);
}
