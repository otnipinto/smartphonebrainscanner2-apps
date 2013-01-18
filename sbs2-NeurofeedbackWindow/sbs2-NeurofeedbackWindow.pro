# Add more folders to ship with the application, here
folder_01.source = qml/sbs2-NeurofeedbackWindow
folder_01.target = qml
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

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/release/ -lsbs2emotivdecryptor
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/debug/ -lsbs2emotivdecryptor
else:unix: LIBS += -L$$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/ -lsbs2emotivdecryptor

INCLUDEPATH += $$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor
DEPENDPATH += $$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor

win32:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/release/sbs2emotivdecryptor.lib
else:win32:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/debug/sbs2emotivdecryptor.lib
else:unix: PRE_TARGETDEPS += $$PWD/../../../../lgk/work/IMM/sbs2-emotiv-decryptor-source/sbs2emotivdecryptor-build-desktop-Qt_4_8_2_in_PATH__System__Debug/libsbs2emotivdecryptor.a
