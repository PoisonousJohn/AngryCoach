#include <QDebug>
#include "DayLog.h"
#include "FoodAmount.h"

DayLog::DayLog(QObject *parent) : QObject(parent)
{
}

void DayLog::addFood(const QString &foodId, float foodAmount)
{
    auto amount = new FoodAmount();
    amount->setAmount(foodAmount);
    amount->setFoodId(foodId);
    auto val = QVariant::fromValue(amount);
    _EatenFood.append(val);
    emit updated();
}

void DayLog::removeFood(int index)
{
    _EatenFood.removeAt(index);
    emit updated();
}
