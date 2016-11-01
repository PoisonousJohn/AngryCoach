#include <QDebug>
#include <QQmlEngine>
#include "QmlDataProvider.h"
#include "DataManager.h"
#include "DayLog.h"
#include "FoodMap.h"
#include "FoodAmount.h"

QmlDataProvider::QmlDataProvider(QObject *parent)
    : QObject(parent)
    , _selectedDate(QDate::currentDate())
    , _dataManager(new DataManager(this))
{
}

const QDate &QmlDataProvider::getSelectedDate() const
{
    return _selectedDate;
}

void QmlDataProvider::setSelectedDate(const QDate &date)
{
    _selectedDate = date;
    emit selectedDateChanged();
}

void QmlDataProvider::addFood(const QVariantMap &data)
{
    _dataManager->addFood(data);
    emit foodChanged();
}

void QmlDataProvider::removeFood(const QString &foodId)
{
    _dataManager->removeFood(foodId);
    emit foodChanged();
    emit dayLogChanged(QDate::currentDate());
}

QVariantList QmlDataProvider::getDayLog(const QDate &date)
{
    QVariantList list;
    auto dayLog = _dataManager->getDayLog(date);
    auto foodMap = _dataManager->getFood();
    auto& foodHash = foodMap->getHash();
    QStringList invalidIds;
    for (QVariant& foodVariant : dayLog->EatenFood())
    {
        auto foodAmount = qvariant_cast<FoodAmount*>(foodVariant);
        QString foodId = foodAmount->FoodId();
        auto food = foodHash.find(foodId);
        if (food != foodHash.end())
        {
            list.append(foodVariant);
        }
        else
        {
            invalidIds.append(foodId);
        }
    }

    for (auto& invalidId : invalidIds)
    {
        foodMap->remove(invalidId);
    }

    return list;
}

void QmlDataProvider::addFoodToLog(const QDate &date, const QString &foodId, float foodAmount)
{
    _dataManager->addFoodToLog(date, foodId, foodAmount);
    emit dayLogChanged(date);
}

void QmlDataProvider::removeFoodFromLog(const QDate &date, int index)
{
    _dataManager->removeFoodFromLog(date, index);
    emit dayLogChanged(date);
}

QVariantList QmlDataProvider::getFood()
{
    QVariantList list;
    for (auto& value : _dataManager->getFood()->getHash())
    {
        list.append(value);
    }
    return list;
}

QObject* QmlDataProvider::getFoodById(const QString &foodId)
{
    const auto& foodHash = _dataManager->getFood()->getHash();
    auto result = foodHash.find(foodId);
    if (result == foodHash.end())
    {
        qDebug() << "Food" << foodId << "not found";
        return nullptr;
    }

    auto obj = qvariant_cast<Food*>(result.value());
    assert(obj != nullptr);
    QQmlEngine::setObjectOwnership(obj, QQmlEngine::CppOwnership);
    return obj;
}
