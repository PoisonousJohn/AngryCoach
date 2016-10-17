#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QStandardPaths>
#include <QJsonDocument>
#include <QFile>
#include "Calories.h"
#include "jenson.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QString dataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QFile dataFile(dataPath + '/' + "data.json" );

    if (!dataFile.open(QIODevice::ReadWrite))
    {
        qDebug() << "Failed to open write file" << dataFile.fileName();
        return 1;
    }

    QQmlApplicationEngine engine;
    engine.addImportPath("material/src");
    QPM_INIT(engine)
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    Calories calories;
    calories.setCarbs(10);
    calories.setFats(20);
    calories.setProteins(30);

    QJsonDocument doc;
    doc.setObject(jenson::JenSON::serialize(&calories));

    return app.exec();
}
