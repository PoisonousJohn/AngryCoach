#ifndef CALORIES_H
#define CALORIES_H

#include <QObject>
#include "jenson.h"

class Calories : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE Calories(QObject* parent = 0);

    JENSON_PROPERTY_GETSET(int, TotalCalories)
    JENSON_PROPERTY_GETSET(int, Carbs)
    JENSON_PROPERTY_GETSET(int, Proteins)
    JENSON_PROPERTY_GETSET(int, Fats)
};

SERIALIZABLE(Calories, Calories)

#endif // CALORIES_H
