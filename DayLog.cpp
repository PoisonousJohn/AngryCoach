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

void DayLog::addRecipe(const QString &recipeId, float amount)
{
    auto foodAmount = new FoodAmount();
    foodAmount->setAmount(amount);
    foodAmount->setFoodId(recipeId);
    auto val = QVariant::fromValue(foodAmount);
    _EatenRecipes.append(val);
    emit updated();

}

void DayLog::removeRecipe(int index)
{
    _EatenRecipes.removeAt(index);
    emit updated();
}
