# Add more folders to ship with the application, here
folder_01.source = qml/sbs2musicalSquares
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE97AE430
QT += network

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    ../../../core/src/FFTReal.cpp \
    ../../../core/src/Rijndael.cpp \
    ../../../core/src/dtuemotivspectrogram.cpp \
    ../../../core/src/dtuemotivtimer.cpp \
    ../../../core/src/dtuemotivfilter.cpp \
    ../../../core/src/dtuemotivcommon.cpp \
    ../../../core/src/dtuemotivdecryptor.cpp \
    ../../../core/src/dtuemotivregion.cpp \
    ../../../core/src/dtuemotivnetworkhandler.cpp \
    ../../../core/src/dtuemotivcallback.cpp \
    ../../../core/src/dtuemotivreader.cpp \
    ../../../core/src/dtuemotivdatahandler.cpp \
    ../../../core/src/dtuemotivfilehandler.cpp \
    ../../../core/src/dtuemotivsourcereconstruction.cpp \
    ../../../core/src/dtuemotivpacket.cpp \
    ../../../core/src/dtuemotivmounter.cpp \
    myemotivcallback.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    android/res/values-zh-rCN/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values-et/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/values-es/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/layout/splash.xml \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/drawable-mdpi/icon.png \
    android/res/values-nl/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable/logo.png \
    android/res/drawable/icon.png \
    android/res/values-ja/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-el/strings.xml \
    android/res/values-pl/strings.xml \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/version.xml \
    android/AndroidManifest.xml

RESOURCES += \
    resources.qrc

INCLUDEPATH += ../../../core/src

macx {
    LIBS += -framework IOKit -framework CoreFoundation
    message("OSX")
    SOURCES += ../../../core/src/hid.c
    HEADERS += ../../../core/src/hidapi.h
}

HEADERS += \
    ../../../core/src/dtu_array_2d.h \
    ../../../core/src/dtuemotivdecryptor.h \
    ../../../core/src/dtuemotivfilter.h \
    ../../../core/src/dtuemotivpacket.h \
    ../../../core/src/dtuemotivspectrogram.h \
    ../../../core/src/dtuemotivtimer.h \
    ../../../core/src/dtuemotivwaiter.h \
    ../../../core/src/dtuemotivcommon.h \
    ../../../core/src/Rijndael.h \
    ../../../core/src/FFTReal.h \
    ../../../core/src/libdecryptor.h \
    ../../../core/src/dtuemotivregion.h \
    ../../../core/src/dtuemotivnetworkhandler.h \
    ../../../core/src/dtuemotivcallback.h \
    ../../../core/src/dtuemotivdatahandler.h \
    ../../../core/src/dtuemotivfilehandler.h \
    ../../../core/src/dtuemotivsourcereconstruction.h \
    ../../../core/src/dtuemotivmounter.h \
    ../../../core/src/dtuemotivreader.h \
    myemotivcallback.h
