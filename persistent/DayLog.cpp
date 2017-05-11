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
    auto foodAmount = qvariant_cast<FoodAmount*>(_EatenFood.at(index));
    foodAmount->deleteLater();
    _EatenFood.removeAt(index);
    emit updated();
}

void DayLog::addRecipe(const QString &recipeId, float amount)
{
    auto foodAmount = new FoodAmount(this);
    foodAmount->setAmount(amount);
    foodAmount->setFoodId(recipeId);
    auto val = QVariant::fromValue(foodAmount);
    _EatenRecipes.append(val);
    emit updated();

}

void DayLog::removeRecipe(int index)
{
    auto foodAmount = qvariant_cast<FoodAmount*>(_EatenRecipes.at(index));
    foodAmount->deleteLater();
    _EatenRecipes.removeAt(index);
    emit updated();
}

void DayLog::setFoodAmount(int index, float amount)
{
    auto foodAmount = qvariant_cast<FoodAmount*>(_EatenFood.at(index));
    foodAmount->setAmount(amount);
    _EatenFood.replace(index, QVariant::fromValue(foodAmount));
    emit updated();
}

void DayLog::setRecipeAmount(int index, float amount)
{
    auto foodAmount = qvariant_cast<FoodAmount*>(_EatenRecipes.at(index));
    foodAmount->setAmount(amount);
    _EatenRecipes.replace(index, QVariant::fromValue(foodAmount));
    emit updated();
}
