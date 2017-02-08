TEMPLATE = app

QT += core qml quick widgets

CONFIG += c++11

SOURCES += $$PWD/thirdParty/jenson/src/*.cpp \
    Ingredient.cpp \
    Food.cpp \
    Calories.cpp \
    DataManager.cpp \
    DayLog.cpp \
    AppData.cpp \
    FoodMap.cpp \
    DayLogCache.cpp \
    QmlDataProvider.cpp \
    FoodAmount.cpp \
    FoodRecipe.cpp \
    RecipeMap.cpp
SOURCES += main.cpp

RESOURCES +=	qml.qrc

INCLUDEPATH += $$PWD/thirdParty
INCLUDEPATH += $$PWD/thirdParty/jenson/src

# Default rules for deployment.
include(deployment.pri)
include(quickflux/quickflux.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH += $$PWD/singletons
#QML2_IMPORT_PATH += $$PWD/singletons
QML_IMPORT_PATH += $$PWD \
                    $$PWD/material/src
QML2_IMPORT_PATH += $$QML_IMPORT_PATH
#QML_IMPORT_PATH += $$PWD/quickflux
#QML2_IMPORT_PATH += $$PWD/quickflux

message("import path" $$QML2_IMPORT_PATH)


HEADERS += \
    Ingredient.h \
    Food.h \
    Calories.h \
    DataManager.h \
    DayLog.h \
    JensonHelper.h \
    AppData.h \
    CustomQHashSerializer.h \
    FoodMap.h \
    DayLogCache.h \
    QmlDataProvider.h \
    FoodAmount.h \
    FoodRecipe.h \
    RecipeMap.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

