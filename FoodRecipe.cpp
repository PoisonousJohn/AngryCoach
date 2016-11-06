#include "FoodRecipe.h"
#include "FoodAmount.h"

FoodRecipe::FoodRecipe(QObject *parent) : QObject(parent)
{

}

void FoodRecipe::addIngredient(const QString &foodId, float foodAmount)
{
    auto amount = new FoodAmount();
    amount->setAmount(foodAmount);
    amount->setFoodId(foodId);
    auto val = QVariant::fromValue(amount);
    _Ingredients.append(val);
    emit updated();
}

void FoodRecipe::removeIngredient(int index)
{
    _Ingredients.removeAt(index);
    emit updated();
}
