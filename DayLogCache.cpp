#include "DayLogCache.h"
#include <QFile>
#include <QDebug>
#include "DayLog.h"
#include "DataManager.h"

DayLogCache::DayLogCache(const QDate &date)
{
    _file = new QFile(DataManager::getDataDir().path() + "/" + date.toString());
    qDebug() << "DayLogCache for date" << date << "initialized with file" << _file;
    if (_file->exists())
    {
        load();
    }
    else
    {
        _log = new DayLog();
        qDebug() << "file" << _file->fileName() << " not found. initilizing default log";
    }
}

DayLogCache::~DayLogCache()
{
    _log->deleteLater();
}

DayLog *DayLogCache::getLog() const
{
    return _log;
}

void DayLogCache::load()
{
    if (!_file->open(QIODevice::ReadWrite))
    {
        qDebug() << "failed to read day log: " << _file->fileName();
        return;
    }
}

