#include <QDebug>
#include "Food.h"

Food::Food(QObject *parent)
    : QObject(parent)
    , _weight(0.f)
{

}

QString Food::Id() const
{
    return _id;
}

void Food::setId(const QString &id)
{
    _id = id;
    emit foodChanged();
}

QString Food::Name() const
{
    return _name;
}

void Food::setName(const QString &name)
{
    _name = name;
    emit foodChanged();
}

float Food::Weight() const
{
    return _weight;
}

Calories *Food::FoodCalories() const
{
    return _foodCalories;
}

void Food::setFoodCalories(Calories *foodCalories)
{
    if (_foodCalories != nullptr)
    {
        _foodCalories->deleteLater();
        _foodCalories = nullptr;
    }
    _foodCalories = foodCalories;
    _foodCalories->setParent(this);
    emit foodChanged();
}

void Food::setWeight(float weight)
{
    _weight = weight;
    emit foodChanged();
}
