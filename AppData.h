#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <QHash>
#include <QUuid>
#include <QVariant>
#include <jenson.h>
#include "Food.h"
#include "CustomQHashSerializer.h"

class FoodMap : public SerializableHash<Food>
{
    Q_OBJECT

public:
    FoodMap(QObject* parent = 0) : SerializableHash(parent) {}
};

//Q_DECLARE_METATYPE(FoodMap)
class FoodMapSerializer : public CustomQHashSerializer<FoodMap>
{

};

CUSTOMSERIALIZABLE(FoodMap, FoodMapSerializer, TheFoodMap)

class AppData : public QObject
{
    Q_OBJECT
public:
    explicit AppData(QObject* parent = 0);
//    Q_PROPERTY(FoodMap food READ food WRITE setFood)
//    FoodMap* food() { return _food; }
//    void setFood(FoodMap* food) { _food = food; }
    QOBJECT_PROPERTY_GETSET(FoodMap, Food)
private:
//    FoodMap* _food = nullptr;
};

SERIALIZABLE(AppData, Data)

#endif // APPDATA_H
