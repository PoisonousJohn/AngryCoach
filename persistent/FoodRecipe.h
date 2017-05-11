#ifndef FOODRECIPE_H
#define FOODRECIPE_H


#include <QObject>
#include <QStringList>
#include "jenson.h"
#include "JensonHelper.h"

class FoodRecipe : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE FoodRecipe(QObject* parent = 0);
    // list of FoodAmount
    JENSON_PROPERTY_GETSET(QString, Id)
    JENSON_PROPERTY_GETSET(QString, Name)
    JENSON_PROPERTY_GETSET(QVariantList, Ingredients)
    JENSON_PROPERTY_GETSET(float, Servings)
    void addIngredient(const QString& foodId, float foodAmount);
    void removeIngredient(int index);
signals:
    void updated();
};

SERIALIZABLE(FoodRecipe, FoodRecipe)


#endif // FOODRECIPE_H
