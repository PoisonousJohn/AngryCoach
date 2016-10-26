#ifndef FOODMAP_H
#define FOODMAP_H

#include "Food.h"
#include "CustomQHashSerializer.h"

class FoodMap : public SerializableHash<Food>
{
    Q_OBJECT

public:
    Q_INVOKABLE FoodMap(QObject* parent = 0) : SerializableHash(parent) {
    }
    Q_PROPERTY(QVariantList list READ getList NOTIFY listChanged)


signals:
    void listChanged();

public:

    QVariantList getList() const;

    void insert(QString key, ItemPtr item) override
    {
        SerializableHash::insert(key, item);
        emit listChanged();
    }
};

class FoodMapSerializer : public CustomQHashSerializer<FoodMap>
{
public:
    FoodMapSerializer() {}

};

CUSTOMSERIALIZABLE(FoodMap, FoodMapSerializer, TheFoodMap)

#endif // FOODMAP_H
