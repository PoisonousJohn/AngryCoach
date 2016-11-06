#ifndef RECIPEMAP_H
#define RECIPEMAP_H

#include "FoodRecipe.h"
#include "CustomQHashSerializer.h"

class RecipeMap : public SerializableHash<FoodRecipe>
{
    Q_OBJECT
public:
    Q_INVOKABLE RecipeMap(QObject* parent = 0) : SerializableHash(parent) {
    }
};

class RecipeMapSerializer : public CustomQHashSerializer<RecipeMap>
{
public:
    RecipeMapSerializer() {}
};

CUSTOMSERIALIZABLE(RecipeMap, RecipeMapSerializer, TheRecipeMap)

#endif // RECIPEMAP_H
