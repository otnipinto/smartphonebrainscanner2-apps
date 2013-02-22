# Add more folders to ship with the application, here
#folder_01.source = qml/sbs2-Brain3D
#folder_01.target = qml
#DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += opengl
# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    mycallback.cpp \
    glm.cpp \
    glwidget.cpp \
    mainwindow.cpp \
    model.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

include(../../smartphonebrainscanner2-core/src/sbs2_binary_decryptor.pri)
#include(../../smartphonebrainscanner2-core/src/sbs2.pri)

HEADERS += \
    mycallback.h \
    colordata.h \
    glm.h \
    glwidget.h \
    mainwindow.h \
    model.h

RESOURCES += \
    resources.qrc

macx: LIBS += -L$$PWD/../../../../google_code_sbs2/decryptor_libraries/ -lsbs2emotivdecryptor_osx_x86_64

INCLUDEPATH += $$PWD/../../../../google_code_sbs2/decryptor_libraries
DEPENDPATH += $$PWD/../../../../google_code_sbs2/decryptor_libraries

macx: PRE_TARGETDEPS += $$PWD/../../../../google_code_sbs2/decryptor_libraries/libsbs2emotivdecryptor_osx_x86_64.a
