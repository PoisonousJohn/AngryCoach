#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QStandardPaths>
#include <QJsonDocument>
#include <QQmlContext>
#include <QFile>
#include <QDir>
#include <QTextStream>
#include "Calories.h"
#include "jenson.h"
#include "DataManager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

//    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
//    if (!dataDir.exists() && !dataDir.mkdir(dataDir.absolutePath()))
//    {
//        qDebug() << "Failed to create data dir" << dataDir.absolutePath();
//        return 1;
//    }

//    QFile dataFile(dataDir.absolutePath() + '/' + "data.json" );

//    if (!dataFile.open(QIODevice::ReadWrite | QIODevice::Truncate))
//    {
//        qDebug() << "Failed to open write file" << dataFile.fileName();
//        return 1;
//    }

//    qDebug() << "data file: " << dataFile.fileName();

    QQmlApplicationEngine engine;

    engine.addImportPath("material/src");
    QPM_INIT(engine)
    engine.rootContext()->setContextProperty("dataManager", new DataManager());
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
