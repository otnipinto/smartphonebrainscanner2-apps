#ifndef NETWORKHANDLER_H
#define NETWORKHANDLER_H

#define QUEUE_LENGTH 16

#include <QString>
#include <QUdpSocket>
#include <vector>
#include <iostream>
#include <QTcpSocket>
#include <QtCore>



class NetworkHandler: public QObject
{
    Q_OBJECT

public:
    NetworkHandler();
    void udpSocketInInit();
    QVector<char *> dataIn;
    void udpSocketOutInit();


private:
    QUdpSocket* udpSocketIn;
    QUdpSocket* udpSocketOut;
    int inPort;
    int outPort;
    QByteArray dataArray;


public slots:
    void readPendingDatagrams();
    void writeData(QString data);

signals:
    void dataReceived(QVariant data);



};

#endif // NETWORKHANDLER_H
