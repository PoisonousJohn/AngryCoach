#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QMap>
#include <QtQml>
#include "QmlDataProvider.h"
#include "AppData.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<AppData>("Fitness", 0, 1, "AppData");
    engine.addImportPath(QStringLiteral("qrc:/"));

    QPM_INIT(engine)
    engine.rootContext()->setContextProperty("dataManager", new QmlDataProvider());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
j
