QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    mainwindow.h

FORMS += \
    mainwindow.ui

macx {
        LIBS+= -L $$PWD$$/ffmpeg/mac/lib/  -lavcodec \
        -lavfilter \
        -lavformat \
        -lavutil \
        -lfdk-aac \
        -lpostproc \
        -lswresample \
        -lswscale \
        -lx264
    INCLUDEPATH +=$$PWD$$/ffmpeg/mac/include
    DEPENDPATH +=$$PWD$$/ffmpeg/mac/include
}


win32 {

}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
