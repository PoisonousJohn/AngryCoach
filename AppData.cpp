#include "AppData.h"

AppData::AppData(QObject *parent)
    : QObject(parent)
    , _Weight(0.f)
    , _Height(0.f)
    , _Age(0)
    , _UserSex(0)
    , _Food(new FoodMap(this))
    , _MassModifier(0)
{

}
