#ifndef FOOD_H
#define FOOD_H

#include <QObject>
#include <QUuid>
#include "Calories.h"
#include "jenson.h"
#include "JensonHelper.h"


class Food : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE Food(QObject *parent = 0);
    STANDARD_PROPERTY_GETSET(QString, Id)
    STANDARD_PROPERTY_GETSET(QString, Name)
    QOBJECT_PROPERTY_GETSET(Calories, FoodCalories)

public slots:
};

SERIALIZABLE(Food, Food)

#endif // FOOD_H
