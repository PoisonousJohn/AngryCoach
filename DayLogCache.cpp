#include "DayLogCache.h"
#include <QFile>

DayLogCache::DayLogCache(QDate date)
{

}

DayLog *DayLogCache::getLog() const
{
    return log;
}

void DayLogCache::setLog(DayLog *value)
{
    log = value;
}

