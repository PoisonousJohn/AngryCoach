#include "DayLogCache.h"
#include <QFile>
#include "DataManager.h"

DayLogCache::DayLogCache(QDate date)
{
    _file = new QFile(DataManager::getDataDir().path() + "/" + date.toString());
}

DayLog *DayLogCache::getLog() const
{
    return _log;
}

void DayLogCache::setLog(DayLog *value)
{
    _log = value;
}

