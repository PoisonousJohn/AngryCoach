#ifndef DAYLOG_H
#define DAYLOG_H

#include <QObject>
#include <QVariantList>
#include "jenson.h"
#include "JensonHelper.h"

class DayLog : public QObject
{
    Q_OBJECT
public:
    DayLog(QObject* parent = 0);
    // food ids
    STANDARD_PROPERTY_GETSET(QStringList, EatenFood)
//     QVariantList of Calories class
//    JENSON_PROPERTY_GETSET(QVariantList, Calories)
signals:
    void updated();
};

SERIALIZABLE(DayLog, DayLog)

#endif // DAYLOG_H
