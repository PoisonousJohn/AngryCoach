#ifndef APPDATA_H
#define APPDATA_H

#include <QtQml>
#include <QObject>
#include <QHash>
#include <QUuid>
#include <QVariant>
#include <jenson.h>
#include "FoodMap.h"
#include "DayLogCache.h"

class AppData : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE explicit AppData(QObject* parent = 0);
    QOBJECT_PROPERTY_GETSET(FoodMap, Food)

private:
    QHash<QDate, DayLogCache> _dayLogCache;
};

SERIALIZABLE(AppData, Data)

#endif // APPDATA_H
