TEMPLATE = app

QT += core qml quick widgets

CONFIG += c++11

SOURCES += $$PWD/thirdParty/jenson/src/*.cpp \
    persistent/Ingredient.cpp \
    persistent/Food.cpp \
    persistent/Calories.cpp \
    persistent/DataManager.cpp \
    persistent/DayLog.cpp \
    persistent/AppData.cpp \
    persistent/FoodMap.cpp \
    persistent/DayLogCache.cpp \
    QmlDataProvider.cpp \
    persistent/FoodAmount.cpp \
    persistent/FoodRecipe.cpp \
    persistent/RecipeMap.cpp
SOURCES += main.cpp

RESOURCES +=	qml.qrc

INCLUDEPATH += $$PWD/thirdParty
INCLUDEPATH += $$PWD/persistent
INCLUDEPATH += $$PWD/thirdParty/jenson/src

# Default rules for deployment.
include(deployment.pri)
include(quickflux/quickflux.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH += $$PWD/singletons
#QML2_IMPORT_PATH += $$PWD/singletons
QML_IMPORT_PATH += $$PWD \
                    $$PWD/views \
                    $$PWD/qmlComponents
QML2_IMPORT_PATH += $$QML_IMPORT_PATH
#QML_IMPORT_PATH += $$PWD/quickflux
#QML2_IMPORT_PATH += $$PWD/quickflux

message("import path" $$QML2_IMPORT_PATH)


HEADERS += \
    persistent/Ingredient.h \
    persistent/Food.h \
    persistent/Calories.h \
    persistent/DataManager.h \
    persistent/DayLog.h \
    persistent/JensonHelper.h \
    persistent/AppData.h \
    persistent/CustomQHashSerializer.h \
    persistent/FoodMap.h \
    persistent/DayLogCache.h \
    QmlDataProvider.h \
    persistent/FoodAmount.h \
    persistent/FoodRecipe.h \
    persistent/RecipeMap.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

