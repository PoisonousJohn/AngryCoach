#include <QDebug>
#include "FoodAmount.h"

FoodAmount::FoodAmount(QObject *parent) : QObject(parent)
{
    qDebug() << "FoodAmount";
}

FoodAmount::~FoodAmount()
{
    qDebug() << "~FoodAmount";
}
