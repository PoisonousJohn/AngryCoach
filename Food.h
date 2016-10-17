#ifndef FOOD_H
#define FOOD_H

#include <QObject>
#include "Calories.h"
#include "jenson.h"

class Food : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE Food(QObject *parent = 0);
//    JENSON_PROPERTY_GETSET(QString, Name)
//    JENSON_PROPERTY_GETSET(Calories, Calories)

signals:

public slots:
};

SERIALIZABLE(Food, Food)

#endif // FOOD_H
