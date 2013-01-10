#include <QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>

#include "mycallback.h"
#include "hardware/emotiv/sbs2emotivdatareader.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qDebug() << "catalogPath: "<<Sbs2Common::setDefaultCatalogPath();
    qDebug() << "rootAppPath: "<<Sbs2Common::setDefaultRootAppPath();

    MyCallback* myCallback = new MyCallback();
    Sbs2EmotivDataReader* sbs2DataReader = Sbs2EmotivDataReader::New(myCallback,0);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/sbs2-NeurofeedbackWindow/main.qml"));
    viewer.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    viewer.showMaximized();
    //viewer.showExpanded();

    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());

    QObject::connect(myCallback,SIGNAL(valueSignal(QVariant)),rootObject,SLOT(valueSlot(QVariant)));

    QObject::connect(app.data(), SIGNAL(aboutToQuit()), sbs2DataReader, SLOT(aboutToQuit()));
	QObject::connect((QObject*)viewer.engine(), SIGNAL(quit()), app.data(), SLOT(quit()));

    return app->exec();
}
