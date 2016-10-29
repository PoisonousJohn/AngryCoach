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

QObject *QmlDataProvider::getDayLog(const QDate &date)
{
    return _dataManager->getDayLog(date);
}

QVariantList QmlDataProvider::getFood()
{
    return _dataManager->getFood()->getList();
}
