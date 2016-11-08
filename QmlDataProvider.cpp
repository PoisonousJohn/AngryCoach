#include <QDebug>
#include <QQmlEngine>
#include "QmlDataProvider.h"
#include "DataManager.h"
#include "DayLog.h"
#include "FoodMap.h"
#include "RecipeMap.h"
#include "FoodAmount.h"
#include "AppData.h"

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
    auto food = new Food();
    mapDataToFood(food, data);
    _dataManager->addFood(food);
    emit foodChanged();
}

void QmlDataProvider::editFood(const QString &foodId, const QVariantMap &data)
{
    auto food = findFood(foodId);
    if (food == nullptr)
    {
        qDebug() << "Food not found for editing" << foodId;
        return;
    }

    mapDataToFood(food, data);
    _dataManager->save();
    emit foodChanged();
    emit dayLogChanged(_selectedDate);
}

void QmlDataProvider::removeFood(const QString &foodId)
{
    _dataManager->removeFood(foodId);
    emit foodChanged();
    emit dayLogChanged(QDate::currentDate());
}

QVariantMap QmlDataProvider::getDayLog(const QDate &date)
{
    QVariantMap map;
    QVariantList list;
    auto dayLog = _dataManager->getDayLog(date);
    auto foodMap = _dataManager->getFood();
    auto& foodHash = foodMap->getHash();
    for (QVariant& foodVariant : dayLog->EatenFood())
    {
        auto foodAmount = qvariant_cast<FoodAmount*>(foodVariant);
        QString foodId = foodAmount->FoodId();
        // filter out deleted food
        auto food = foodHash.find(foodId);
        if (food != foodHash.end())
        {
            list.append(foodVariant);
        }
    }

    QVariantList recipesList;
    auto recipesMap = _dataManager->getRecipes();
    auto& recipesHash = recipesMap->getHash();
    for (QVariant& recipeVariant : dayLog->EatenRecipes())
    {
        auto foodAmount = qvariant_cast<FoodAmount*>(recipeVariant);
        QString foodId = foodAmount->FoodId();
        // filter out deleted food
        auto food = recipesHash.find(foodId);
        if (food != recipesHash.end())
        {
            recipesList.append(recipeVariant);
        }
    }

    map["Food"] = list;
    map["Recipes"] = recipesList;

    return map;
}

void QmlDataProvider::addFoodToLog(const QDate &date, const QString &foodId, float foodAmount)
{
    _dataManager->addFoodToLog(date, foodId, foodAmount);
    emit dayLogChanged(date);
}

void QmlDataProvider::addRecipeToLog(const QDate &date, const QString &recipeId, float amount)
{
    _dataManager->addRecipeToLog(date, recipeId, amount);
    emit dayLogChanged(date);
}

void QmlDataProvider::removeFoodFromLog(const QDate &date, int index)
{
    _dataManager->removeFoodFromLog(date, index);
    emit dayLogChanged(date);
}

void QmlDataProvider::removeRecipeFromLog(const QDate &date, int index)
{
    _dataManager->removeRecipeFromLog(date, index);
    emit dayLogChanged(date);
}

QVariantMap QmlDataProvider::getFoodValuesForForm(const QString &foodId)
{
    QVariantMap map;

    auto food = findFood(foodId);
    if (food == nullptr)
    {
        return map;
    }

    map["Name"] = food->Name();
    map["Carbs"] = getStringFromFloat(food->FoodCalories()->Carbs());
    map["Proteins"] = getStringFromFloat(food->FoodCalories()->Proteins());
    map["Fats"] = getStringFromFloat(food->FoodCalories()->Fats());
    map["TotalCalories"] = getStringFromFloat(food->FoodCalories()->TotalCalories());
    map["Weight"] = getStringFromFloat(food->Weight());

    return map;
}

QVariantMap QmlDataProvider::getUserProfileModel()
{
    QVariantMap map;
    auto data = _dataManager->getData();

    map.insert("Weight", data->Weight());
    map.insert("Height", data->Height());
    map.insert("Age", data->Age());
    map.insert("Sex", data->UserSex());
    map.insert("MassModifier", data->MassModifier());
    map.insert("MassModifierFactor", 1.f - data->MassModifier() * 0.1f);

    return map;
}

void QmlDataProvider::updateUserProfile(const QVariantMap &data)
{
    auto appData = _dataManager->getData();
    appData->setWeight(getFloat(data["Weight"]));
    appData->setHeight(getFloat(data["Height"]));
    appData->setAge(data["Age"].toInt());
    appData->setUserSex(data["Sex"].toInt());
    appData->setMassModifier(data["MassModifier"].toInt());
    _dataManager->save();
    emit userProfileChanged();
}

QVariantMap QmlDataProvider::getRecipeValuesForForm(const QString &recipeId)
{
    QVariantMap map;

    auto recipe = findRecipe(recipeId);
    if (recipe == nullptr)
    {
        return map;
    }

    map["Id"] = recipe->Id();
    map["Name"] = recipe->Name();
    map["Ingredients"] = recipe->Ingredients();
    map["Servings"] = recipe->Servings();

    return map;

}

Food *QmlDataProvider::findFood(const QString &foodId)
{
    const auto& foodHash = _dataManager->getFood()->getHash();
    auto result = foodHash.find(foodId);
    if (result == foodHash.end())
    {
        qDebug() << "Food" << foodId << "not found";
        return nullptr;
    }

    auto obj = qvariant_cast<Food*>(result.value());
    return obj;
}

FoodRecipe *QmlDataProvider::findRecipe(const QString &recipeId)
{
    const auto& hash = _dataManager->getRecipes()->getHash();
    auto result = hash.find(recipeId);
    if (result == hash.end())
    {
        qDebug() << "Recipe" << recipeId << "not found";
        return nullptr;
    }

    auto obj = qvariant_cast<FoodRecipe*>(result.value());
    return obj;
}

float QmlDataProvider::getFloat(const QVariant &variant) const
{
    auto loc = QLocale();
    return loc.toFloat(variant.toString());
}

void QmlDataProvider::mapDataToFood(Food *food, const QVariantMap &data)
{
    food->setName(data["Name"].toString());
    auto calories = new Calories();
    calories->setCarbs(getFloat(data["Carbs"]));
    calories->setProteins(getFloat(data["Proteins"]));
    calories->setFats(getFloat(data["Fats"]));
    calories->setTotalCalories(getFloat(data["TotalCalories"]));
    food->setFoodCalories(calories);
    food->setWeight(getFloat(data["Weight"]));
}

void QmlDataProvider::mapDataToRecipe(FoodRecipe *recipe, const QVariantMap &data)
{
    recipe->setName(data["Name"].toString());
    recipe->setServings(data["Servings"].toFloat());
    QVariantList list;
    for (auto& item : data["Ingredients"].toList())
    {
        auto amount = new FoodAmount();
        auto obj = qvariant_cast<QObject*>(item);
        amount->setFoodId(obj->property("FoodId").toString());
        amount->setAmount(obj->property("Amount").toFloat());
        list.append(QVariant::fromValue(amount));
    }
    recipe->setIngredients(list);
}

QString QmlDataProvider::getStringFromFloat(float value)
{
    QLocale loc;
    return loc.toString(value, 'f', 2);
}

QVariantList QmlDataProvider::getFood()
{
    QVariantList list;
    auto food = _dataManager->getFood();
    if (food == nullptr)
    {
        return list;
    }
    for (auto& value : food->getHash())
    {
        list.append(value);
    }
    return list;
}

QObject* QmlDataProvider::getFoodById(const QString &foodId)
{
    auto obj = findFood(foodId);
    QQmlEngine::setObjectOwnership(obj, QQmlEngine::CppOwnership);
    return obj;
}

void QmlDataProvider::addRecipe(const QVariantMap &data)
{
    auto recipe = new FoodRecipe();
    mapDataToRecipe(recipe, data);
    _dataManager->addRecipe(recipe);
    emit recipesChanged();
}

void QmlDataProvider::editRecipe(const QString &recipeId, const QVariantMap &data)
{
    auto food = findRecipe(recipeId);
    if (food == nullptr)
    {
        qDebug() << "Recipe not found for editing" << recipeId;
        return;
    }

    mapDataToRecipe(food, data);
    _dataManager->save();
    emit recipesChanged();
    emit dayLogChanged(_selectedDate);
}

void QmlDataProvider::removeRecipe(const QString &recipeId)
{
    _dataManager->removeRecipe(recipeId);
    emit recipesChanged();
    emit dayLogChanged(_selectedDate);
}

QVariantList QmlDataProvider::getRecipes()
{
    QVariantList list;
    auto recipes = _dataManager->getRecipes();
    if (recipes == nullptr)
    {
        return list;
    }
    for (auto& value : recipes->getHash())
    {
        list.append(value);
    }
    return list;

}

QObject *QmlDataProvider::getRecipeById(const QString &recipeId)
{
    auto obj = findRecipe(recipeId);
    QQmlEngine::setObjectOwnership(obj, QQmlEngine::CppOwnership);
    return obj;
}
