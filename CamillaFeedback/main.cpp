#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QDeclarativeView>
#include <QGraphicsObject>
#include <networkhandler.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{


    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    NetworkHandler* networkHandler = new NetworkHandler();

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer->setMainQmlFile(QLatin1String("qml/CamillaFeedback/main.qml"));

    QObject *rootObject = viewer->rootObject();

    QObject::connect(networkHandler,SIGNAL(dataReceived(QVariant)),rootObject,SLOT(dataReceived(QVariant)));

#ifdef Q_WS_MAEMO_5
     viewer->showFullScreen();
#else
    viewer->show();
#endif

    return app->exec();

}
