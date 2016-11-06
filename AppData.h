#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <jenson.h>
#include "FoodMap.h"
#include "DayLogCache.h"


class AppData : public QObject
{
    Q_OBJECT
    Q_ENUMS(Sex)
public:

    enum class Sex {
        Male,
        Female
    };

    Q_INVOKABLE explicit AppData(QObject* parent = 0);
    QOBJECT_PROPERTY_GETSET(FoodMap, Food)
    JENSON_PROPERTY_GETSET(float, Weight)
    JENSON_PROPERTY_GETSET(float, Height)
    JENSON_PROPERTY_GETSET(int, Age)
    JENSON_PROPERTY_GETSET(int, UserSex)
    JENSON_PROPERTY_GETSET(int, MassModifier)
};

SERIALIZABLE(AppData, Data)

#endif // APPDATA_H
