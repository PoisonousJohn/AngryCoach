#include "AppData.h"

AppData::AppData(QObject *parent) : QObject(parent)
{

}

QVariantList FoodMap::getList() const
{
    QVariantList list;
    for (auto& item : getHash())
    {
        list.append(item);
    }

    return list;
}
