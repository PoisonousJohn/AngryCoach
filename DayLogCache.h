#ifndef DAYLOGCACHE_H
#define DAYLOGCACHE_H

#include <QDate>
class QFile;

class DayLog;

class DayLogCache {
public:
    DayLogCache(QDate date);

    DayLog *getLog() const;
    void setLog(DayLog *value);    

private:
    QFile* _file = nullptr;
    DayLog* _log = nullptr;
};


#endif // DAYLOGCACHE_H
