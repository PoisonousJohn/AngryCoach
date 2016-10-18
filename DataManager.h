#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QDate>
class DayLog;

class DataManager : public QObject
{
    Q_OBJECT
public:
    explicit DataManager(QObject *parent = 0);

    DayLog* getDayLog(QDate date);
    DayLog* getTodayLog();

signals:

public slots:
};

#endif // DATAMANAGER_H
