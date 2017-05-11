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
    Q_PROPERTY(QString Id READ Id WRITE setId NOTIFY foodChanged)
    Q_PROPERTY(QString Name READ Name WRITE setName NOTIFY foodChanged)
    Q_PROPERTY(float Weight READ Weight WRITE setWeight NOTIFY foodChanged)
    Q_PROPERTY(Calories* FoodCalories READ FoodCalories WRITE setFoodCalories NOTIFY foodChanged)

    QString Id() const;
    void setId(const QString &id);

    QString Name() const;
    void setName(const QString &name);

    float Weight() const;
    void setWeight(float weight);

    Calories *FoodCalories() const;
    void setFoodCalories(Calories *foodCalories);

signals:
    void foodChanged();

public slots:

private:

private:
    QString _id;
    QString _name;
    float _weight;
    Calories* _foodCalories = nullptr;
};

SERIALIZABLE(Food, Food)

#endif // FOOD_H
