#include <QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>

#include "mycallback.h"
#include "settingswrapper.h"
#include "colorutils.h"

#include "hardware/emotiv/sbs2emotivdatareader.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    // The following will be used for settings.
    QCoreApplication::instance()->setOrganizationName("IMM");
    QCoreApplication::instance()->setOrganizationDomain("IMM");
    QCoreApplication::instance()->setApplicationName("MentalRotation");

    qDebug() << "catalogPath: "<<Sbs2Common::setDefaultCatalogPath();
    qDebug() << "rootAppPath: "<<Sbs2Common::setDefaultRootAppPath();

    MyCallback* myCallback = new MyCallback();
    Sbs2EmotivDataReader* sbs2DataReader = Sbs2EmotivDataReader::New(myCallback,0);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    SettingsWrapper* settingsWrapper = new SettingsWrapper(app.data());

#if defined(Q_OS_ANDROID)
    settingsWrapper->setValue("ImageBasePath", settingsWrapper->value("ImageBasePath", "/sdcard/smartphonebrainscanner2_data/mentalrotation256"));
#else
    settingsWrapper->setValue("ImageBasePath", settingsWrapper->value("ImageBasePath", QDir::toNativeSeparators(QDir::homePath())+"/smartphonebrainscanner2_data/mentalrotation256"));
#endif

    viewer.rootContext()->setContextProperty("AppSettings", settingsWrapper);

    ColorUtils* colorUtils = new ColorUtils(app.data());
    viewer.rootContext()->setContextProperty("ColorUtils", colorUtils);

    viewer.setMainQmlFile(QLatin1String("qml/main.qml"));

    viewer.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    //viewer.showFullScreen();
    viewer.showExpanded();


    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());

    QObject::connect(myCallback,SIGNAL(valueSignal(QVariant)),rootObject,SLOT(valueSlot(QVariant)));
    QObject::connect(myCallback,SIGNAL(cqValues(QVariant,QVariant)),rootObject,SLOT(cqChanged(QVariant,QVariant)));

    QObject::connect(app.data(), SIGNAL(aboutToQuit()), sbs2DataReader, SLOT(aboutToQuit()));
	QObject::connect((QObject*)viewer.engine(), SIGNAL(quit()), app.data(), SLOT(quit()));

    QObject::connect(rootObject,SIGNAL(startRecording(QString,QString)),
                     myCallback,SLOT(startRecording(QString,QString)));
    QObject::connect(rootObject,SIGNAL(stopRecording()),myCallback,SLOT(stopRecording()));

    QObject::connect(rootObject,SIGNAL(turnSpectrogramOff()),myCallback,SLOT(turnChannelSpectrogramOff()));
    QObject::connect(rootObject,SIGNAL(turnSpectrogramOn(int,int,int)),myCallback,SLOT(turnChannelSpectrogramOn(int,int,int)));


    return app->exec();
}
