#ifndef INGREDIENT_H
#define INGREDIENT_H

#include <QObject>
#include "jenson.h"
#include "JensonHelper.h"
#include "Calories.h"

class Ingredient : public QObject
{
    Q_OBJECT
public:
    explicit Ingredient(QObject *parent = 0);

    QOBJECT_PROPERTY_GETSET(Calories, InredientCalories)

signals:

public slots:
};

SERIALIZABLE(Ingredient, Ingredient)

#endif // INGREDIENT_H
