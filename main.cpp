#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QMap>
#include "QmlDataProvider.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;


    engine.addImportPath("material/src");
    QPM_INIT(engine)
    engine.rootContext()->setContextProperty("dataManager", new QmlDataProvider());
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
