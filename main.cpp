#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QMap>
#include "Calories.h"
#include "jenson.h"
#include "DataManager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QVariantMap testMap;
    testMap.insert("test value 1", "ttt");

    engine.addImportPath("material/src");
    QPM_INIT(engine)
    engine.rootContext()->setContextProperty("dataManager", new DataManager());
    engine.rootContext()->setContextProperty("testMap", testMap);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    Calories calories;
//    calories.setCarbs(10);
//    calories.setFats(20);
//    calories.setProteins(30);

//    QJsonDocument doc;
//    doc.setObject(jenson::JenSON::serialize(&calories));
//    {
//        QTextStream stream(&dataFile);
//        stream << doc.toJson();
//    }

    return app.exec();
}
