QT += opengl
QT += core gui
QT += widgets

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    mycallback.cpp \
    scalpmap.cpp \
    mainwindow.cpp \
    glwidget.cpp



include(../../smartphonebrainscanner2-core/src/sbs2.pri)

HEADERS += \
    mycallback.h \
    scalpmap.h \
    mainwindow.h \
    glwidget.h

include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    resources.qrc
