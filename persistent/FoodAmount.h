#ifndef FOODAMOUNT_H
#define FOODAMOUNT_H

#include <QObject>
#include "jenson.h"

class FoodAmount : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE FoodAmount(QObject *parent = 0);
    ~FoodAmount();
    JENSON_PROPERTY_GETSET(float, Amount)
    JENSON_PROPERTY_GETSET(QString, FoodId)

signals:

public slots:
};

SERIALIZABLE(FoodAmount, FoodAmount)

#endif // FOODAMOUNT_H
