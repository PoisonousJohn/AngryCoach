#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <QHash>
#include <QUuid>
#include <QVariant>
#include <jenson.h>
#include "Food.h"
using FoodMap = QHash<QUuid, QVariant>;

class AppData : public QObject
{
    Q_OBJECT
public:
    explicit AppData(QObject* parent = 0);
    Q_PROPERTY(FoodMap food READ food WRITE setFood)
    FoodMap& food() { return _food; }
    void setFood(const FoodMap& food) { _food = food; }
private:
    FoodMap _food;
};

Q_DECLARE_METATYPE(FoodMap)
SERIALIZABLE(AppData, Data)

#endif // APPDATA_H
