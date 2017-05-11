#ifndef CALORIES_H
#define CALORIES_H

#include <QObject>
#include "jenson.h"

class Calories : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE Calories(QObject* parent = 0);

    JENSON_PROPERTY_GETSET(float, TotalCalories)
    JENSON_PROPERTY_GETSET(float, Carbs)
    JENSON_PROPERTY_GETSET(float, Proteins)
    JENSON_PROPERTY_GETSET(float, Fats)
};

SERIALIZABLE(Calories, Calories)

#endif // CALORIES_H
