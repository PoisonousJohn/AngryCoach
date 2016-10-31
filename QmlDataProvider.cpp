#include "QmlDataProvider.h"
#include "DataManager.h"
#include "DayLog.h"
#include "FoodMap.h"

QmlDataProvider::QmlDataProvider(QObject *parent)
    : QObject(parent)
    , _dataManager(new DataManager(this))
{

}

void QmlDataProvider::addFood(const QVariantMap &data)
{
    _dataManager->addFood(data);
    emit foodChanged();
}

QVariantList QmlDataProvider::getDayLog(const QDate &date)
{
    QVariantList list;
    auto dayLog = _dataManager->getDayLog(date);
    auto foodHash = _dataManager->getFood()->getHash();
    for (auto& foodId : dayLog->EatenFood())
    {
        auto food = foodHash.find(foodId);
        if (food != foodHash.end())
        {
            list.append(QVariant::fromValue(*food));
        }
    }
    return list;
}

void QmlDataProvider::addFoodToLog(const QDate &date, const QString &foodId)
{
    _dataManager->addFoodToLog(date, foodId);
    emit dayLogChanged(date);
}

QVariantList QmlDataProvider::getFood()
{
    return _dataManager->getFood()->getList();
}
