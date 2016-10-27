#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <jenson.h>
#include "FoodMap.h"
#include "DayLogCache.h"

class AppData : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE explicit AppData(QObject* parent = 0);
    QOBJECT_PROPERTY_GETSET(FoodMap, Food)
};

SERIALIZABLE(AppData, Data)

#endif // APPDATA_H
