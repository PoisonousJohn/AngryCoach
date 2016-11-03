#include <QDebug>
#include <QDir>
#include <QJsonDocument>
#include <QStandardPaths>
#include <QTextStream>
#include "DataManager.h"
#include "Food.h"
#include "AppData.h"
#include "DayLog.h"

DataManager::DataManager(QObject *parent) : QObject(parent)
{
    qDebug() << "Data manager started";
    load();
    qDebug() << "Data manager loaded";

}

DayLog* DataManager::getDayLog(const QDate& date)
{
    return getDayLogCache(date)->getLog();
}

FoodMap* DataManager::getFood()
{
    return _data->Food();
}

void DataManager::addFood(Food *food)
{
   food->setId(QUuid::createUuid().toString());
   qDebug() << "Added food with id " << food->Id();
   _data->Food()->insert(food->Id(), food);
   save();
}

void DataManager::removeFood(const QString &foodId)
{
    _data->Food()->remove(foodId);
    save();
}

AppData *DataManager::getData()
{
    return _data;
}

void DataManager::addFoodToLog(const QDate &date, const QString &foodId, float foodAmount)
{
    getDayLog(date)->addFood(foodId, foodAmount);
}

void DataManager::removeFoodFromLog(const QDate &date, int index)
{
    getDayLog(date)->removeFood(index);
}

QDir DataManager::getDataDir()
{
    return QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
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

    if (!_dataFile->open(QIODevice::ReadWrite))
    {
        throw std::exception();
    }
    qDebug() << "data file path" << _dataFile->fileName();

    QJsonParseError* err = nullptr;
    auto jDoc = QJsonDocument::fromJson(_dataFile->readAll(), err);
    if (err != nullptr)
    {
        qDebug() << "Failed to parse json";
        initNewSave();
    }
    else
    {
        try {
            auto jObj = jDoc.object();
            _data = jenson::JenSON::deserialize<AppData>(&jObj).release();

        } catch (const std::exception& ex){
            initNewSave();
            qDebug() << "Error deserializing save" << ex.what();
        }

    }
}

void DataManager::save()
{
    QJsonDocument doc;
    _dataFile->resize(0);
    doc.setObject(jenson::JenSON::serialize(_data));
    {
        QTextStream stream(_dataFile);
        stream << doc.toJson();
    }

    qDebug() << "Data manager saved";
}

void DataManager::initNewSave()
{
    _data = new AppData();
    if (_data->Food() == nullptr)
    {
        _data->setFood(new FoodMap());
    }
}

QSharedPointer<DayLogCache> DataManager::getDayLogCache(const QDate &date)
{
    auto result = _dayLogCache.find(date);
    if (result != _dayLogCache.end())
    {
        return result.value();
    }

    auto cache = QSharedPointer<DayLogCache>::create(date);
    _dayLogCache.insert(date, cache);

    connect(cache->getLog(), &DayLog::updated, [date, this]() {
        saveDayLog(date);
    });

    return getDayLogCache(date);
}

void DataManager::saveDayLog(const QDate &date)
{
    getDayLogCache(date)->save();
}
