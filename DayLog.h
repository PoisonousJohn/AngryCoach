#ifndef DAYLOG_H
#define DAYLOG_H

#include <QObject>
#include <QVariantList>
#include "jenson.h"

class DayLog : public QObject
{
    Q_OBJECT
public:
    DayLog(QObject* parent = 0);
    // QVariantList of Calories class
    JENSON_PROPERTY_GETSET(QVariantList, Calories)
};

SERIALIZABLE(DayLog, DayLog)

#endif // DAYLOG_H
