#include "FoodMap.h"

QVariantList FoodMap::getList() const
{
    QVariantList list;
    for (auto& item : getHash())
    {
        list.append(item);
    }

    return list;
}
