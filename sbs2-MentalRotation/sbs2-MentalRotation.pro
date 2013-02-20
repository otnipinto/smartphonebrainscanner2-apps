# Add more folders to ship with the application, here
folder_01.source = qml
folder_01.target = .
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    mycallback.cpp \
    colorutils.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

#include(../../smartphonebrainscanner2-core/src/sbs2.pri)
include(../../smartphonebrainscanner2-core/src/sbs2_binary_decryptor.pri)

HEADERS += \
    mycallback.h \
    settingswrapper.h \
    colorutils.h

RESOURCES += \
    resources.qrc

message( $$CONFIG )

android: {
    OTHER_FILES += \
        android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
        android/src/org/kde/necessitas/ministro/IMinistro.aidl \
        android/src/org/kde/necessitas/origo/QtApplication.java \
        android/src/org/kde/necessitas/origo/QtActivity.java \
        android/version.xml \
        android/res/layout/splash.xml \
        android/res/values-ru/strings.xml \
        android/res/values-ro/strings.xml \
        android/res/values-fr/strings.xml \
        android/res/values-zh-rCN/strings.xml \
        android/res/values-de/strings.xml \
        android/res/values-nl/strings.xml \
        android/res/values-it/strings.xml \
        android/res/values-pl/strings.xml \
        android/res/values/strings.xml \
        android/res/values-ja/strings.xml \
        android/res/values-fa/strings.xml \
        android/res/values-et/strings.xml \
        android/res/values-ms/strings.xml \
        android/res/values-id/strings.xml \
        android/res/values-zh-rTW/strings.xml \
        android/res/values-el/strings.xml \
        android/res/values-rs/strings.xml \
        android/res/values-es/strings.xml \
        android/res/values-pt-rBR/strings.xml \
        android/res/values-nb/strings.xml \
        android/AndroidManifest.xml \
        android/res/drawable-hdpi/icon.png \
        android/res/drawable-ldpi/icon.png \
        android/res/drawable/icon.png \
        android/res/drawable/logo.png \
        android/res/values/libs.xml \
        android/res/drawable-mdpi/icon.png

    LIBS += -L$$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor_armv7a_Debug/ -lsbs2emotivdecryptor
    INCLUDEPATH += $$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor
    DEPENDPATH += $$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor
    PRE_TARGETDEPS += $$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor_armv7a_Debug/libsbs2emotivdecryptor.a
}

!android: {
    unix:!macx: LIBS += -L$$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/ -lsbs2emotivdecryptor
    INCLUDEPATH += $$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor
    DEPENDPATH += $$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor
    unix:!macx: PRE_TARGETDEPS += $$PWD/../../sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/libsbs2emotivdecryptor.a
}
