TEMPLATE = app

QT += core qml quick widgets

CONFIG += c++11

SOURCES += $$PWD/thirdParty/jenson/src/*.cpp \
    Ingredient.cpp \
    Food.cpp \
    Calories.cpp \
    DataManager.cpp \
    DayLog.cpp \
    AppData.cpp
SOURCES += main.cpp

RESOURCES += qml.qrc

INCLUDEPATH += $$PWD/thirdParty
INCLUDEPATH += $$PWD/thirdParty/jenson/src

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD/material/src
QML2_IMPORT_PATH += $$PWD/material/src

message("import path" $$QML2_IMPORT_PATH)

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    Ingredient.h \
    Food.h \
    Calories.h \
    DataManager.h \
    DayLog.h \
    JensonHelper.h \
    AppData.h
