#ifndef DAYLOGCACHE_H
#define DAYLOGCACHE_H

#include <QDate>
class QFile;

class DayLog;

class DayLogCache {
public:
    DayLogCache(const QDate& date);
    ~DayLogCache();
    DayLog *getLog() const;

    void save();

private:
    void load();
    void initEmptyLog();

private:
    QFile* _file = nullptr;
    DayLog* _log = nullptr;
};


#endif // DAYLOGCACHE_H
