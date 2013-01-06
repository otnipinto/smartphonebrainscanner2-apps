#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <dtuemotivreader.h>
#include <myemotivcallback.h>
#include <QtDeclarative>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    //set path where recorded data will be stored
    qDebug() << "catalogPath: "<<DtuEmotivCommon::setDefaultCatalogPath();
    //set path where application data is stored
    qDebug() << "rootAppPath: "<<DtuEmotivCommon::setDefaultRootAppPath();

    MyEmotivCallback* myEmotivCallback = new MyEmotivCallback();
    //DtuEmotivReader* dtuEmotivReader = DtuEmotivReader::New(myEmotivCallback,0);
    DtuEmotivReader* dtuEmotivReader = DtuEmotivReader::New(myEmotivCallback,0,0);
    //TODO: here
    dtuEmotivReader->turnReceiveUdpDataOn("127.0.0.1",7777);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setMainQmlFile(QLatin1String("qml/sbs2musicalSquares/main.qml"));
    viewer.showExpanded();

    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());


    QObject::connect(myEmotivCallback,SIGNAL(powerValue(QVariant)),rootObject,SLOT(powerValue(QVariant)));
    QObject::connect(myEmotivCallback,SIGNAL(cqValues(QVariant,QVariant)),rootObject,SLOT(cqChanged(QVariant,QVariant)));


    QObject::connect(app.data(), SIGNAL(aboutToQuit()), dtuEmotivReader, SLOT(aboutToQuit()));
    QObject::connect((QObject*)viewer.engine(), SIGNAL(quit()), app.data(), SLOT(quit()));

    QObject::connect(rootObject,SIGNAL(turnSpectrogramOff()),myEmotivCallback,SLOT(turnChannelSpectrogramOff()));
    QObject::connect(rootObject,SIGNAL(turnSpectrogramOn(int,int,int)),myEmotivCallback,SLOT(turnChannelSpectrogramOn(int,int,int)));


    QObject::connect(rootObject,SIGNAL(startRecording(QString,QString)),myEmotivCallback,SLOT(startRecording(QString,QString)));
    QObject::connect(rootObject,SIGNAL(stopRecording()),myEmotivCallback,SLOT(stopRecording()));


    QObject::connect(rootObject,SIGNAL(event(QString)),myEmotivCallback,SLOT(insertIntoMetaFile(QString)));

    return app->exec();
}
