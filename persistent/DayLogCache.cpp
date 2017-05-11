#include "DayLogCache.h"
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include "DayLog.h"
#include "DataManager.h"

DayLogCache::DayLogCache(const QDate &date)
{
    _file = new QFile(DataManager::getDataDir().path() + "/" + date.toString(Qt::ISODate) + ".log");
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

void DayLogCache::save()
{
    qDebug() << "Saving day log";
    if (!_file->isOpen())
    {
        if (!_file->open(QIODevice::ReadWrite))
        {
            qDebug() << "failed to create day log: " << _file->fileName();
            return;
        }
    }

    QJsonDocument doc;
    doc.setObject(jenson::JenSON::serialize(_log));
    {
        _file->resize(0);
        QTextStream stream(_file);
        stream << doc.toJson();
    }

    qDebug() << "Day log" << _file->fileName() << "saved";
}

void DayLogCache::load()
{
    if (!_file->open(QIODevice::ReadWrite))
    {
        qDebug() << "failed to read day log: " << _file->fileName();
        initEmptyLog();
        return;
    }

    QJsonParseError* err = nullptr;
    auto jDoc = QJsonDocument::fromJson(_file->readAll(), err);
    if (err != nullptr)
    {
        qDebug() << "Failed to parse json for day log" << _file->fileName();
        initEmptyLog();
    }
    else
    {
        try {
            auto jObj = jDoc.object();
            _log = jenson::JenSON::deserialize<DayLog>(&jObj).release();

        } catch (const std::exception& ex){
            qDebug() << "Error deserializing day log" << _file->fileName() << ex.what();
            initEmptyLog();
        }

    }

}

void DayLogCache::initEmptyLog()
{
    _log = new DayLog();
}

