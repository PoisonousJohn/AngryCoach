#ifndef DAYLOG_H
#define DAYLOG_H

#include <QObject>
#include <QStringList>
#include "jenson.h"
#include "JensonHelper.h"

class DayLog : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE DayLog(QObject* parent = 0);
    // food ids
    STANDARD_PROPERTY_GETSET(QStringList, EatenFood)
    void addFood(const QString& foodId);
    void removeFood(int index);
signals:
    void updated();
};

SERIALIZABLE(DayLog, DayLog)

#endif // DAYLOG_H
