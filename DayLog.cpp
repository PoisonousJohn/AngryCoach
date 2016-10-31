#include <QDebug>
#include "DayLog.h"

DayLog::DayLog(QObject *parent) : QObject(parent)
{
}

void DayLog::addFood(const QString &foodId)
{
    _EatenFood.append(foodId);
    emit updated();
}
