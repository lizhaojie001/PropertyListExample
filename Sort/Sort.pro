QT -= gui

CONFIG += c++11 console
CONFIG -= app_bundle

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        bubblesort.cpp \
        bubblesort1.cpp \
        bubblesort2.cpp \
        main.cpp \
        randomint.cpp \
        selectionsort.cpp \
        sort.cpp

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    bubblesort.h \
    bubblesort1.h \
    bubblesort2.h \
    randomint.h \
    selectionsort.h \
    sort.h
