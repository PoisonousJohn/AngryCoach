#ifndef DAYLOG_H
#define DAYLOG_H

#include <QObject>
#include <QStringList>
#include "jenson.h"
#include "JensonHelper.h"

class DayLog : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE DayLog(QObject* parent = 0);
    // list of FoodAmount
    JENSON_PROPERTY_GETSET(QVariantList, EatenFood)
    JENSON_PROPERTY_GETSET(QVariantList, EatenRecipes)
    void addFood(const QString& foodId, float foodAmount);
    void removeFood(int index);
    void addRecipe(const QString& recipeId, float amount);
    void removeRecipe(int index);
signals:
    void updated();
};

SERIALIZABLE(DayLog, DayLog)

#endif // DAYLOG_H
