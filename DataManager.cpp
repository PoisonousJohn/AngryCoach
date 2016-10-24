#include <QDebug>
#include <QDir>
#include <QJsonDocument>
#include <QStandardPaths>
#include <QTextStream>
#include "DataManager.h"
#include "Food.h"
#include "AppData.h"

DataManager::DataManager(QObject *parent) : QObject(parent)
{
    qDebug() << "Data manager started";
    load();
    qDebug() << "Data manager loaded";

}

DayLog *DataManager::getDayLog(QDate date)
{

}

DayLog *DataManager::getTodayLog()
{

}

const QHash<QUuid, QVariant> *DataManager::getFood() const
{
    return &_data->food();
}

void DataManager::addFood(Food *food)
{
   food->setId(QUuid::createUuid());
   qDebug() << "Added food with id " << food->Id();
   _data->food().insert(food->Id(), QVariant::fromValue(food));
}

void DataManager::addFood(const QVariantMap &data)
{
   auto food = new Food();
   food->setName(data["name"].toString());
   auto calories = new Calories();
   calories->setCarbs(data["carbs"].toInt());
   calories->setProteins(data["proteins"].toInt());
   calories->setFats(data["fats"].toInt());
   calories->setTotalCalories(data["totalCalories"].toInt());
   food->setFoodCalories(calories);
   addFood(food);
   save();
}

void DataManager::load()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    if (!dataDir.exists() && !dataDir.mkdir(dataDir.absolutePath()))
    {
        qDebug() << "Failed to create data dir" << dataDir.absolutePath();
        throw std::exception();
    }

    _dataFile = new QFile(dataDir.absolutePath() + '/' + "data.json", this);

    if (!_dataFile->open(QIODevice::ReadWrite | QIODevice::Truncate))
    {
        throw std::exception();
    }
    qDebug() << "data file path" << _dataFile->fileName();

   _data = new AppData();
}

void DataManager::save()
{
    QJsonDocument doc;
    doc.setObject(jenson::JenSON::serialize(_data));
    {
        QTextStream stream(_dataFile);
        stream << doc.toJson();
    }

    qDebug() << "Data manager saved";
}
