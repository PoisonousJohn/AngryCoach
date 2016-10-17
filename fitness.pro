TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += material/src
QML2_IMPORT_PATH += material/src
QML_IMPORT_PATH += "qrc:/"
QML2_IMPORT_PATH += "qrc:/"

# Default rules for deployment.
include(deployment.pri)
