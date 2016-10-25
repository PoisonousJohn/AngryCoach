#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QHash>
#include <QDate>
#include <QUuid>
#include <QFile>
#include "CustomQHashSerializer.h"
class AppData;
class DayLog;
class Food;

class DataManager : public QObject
{
    Q_OBJECT
public:
    explicit DataManager(QObject *parent = 0);

    DayLog* getDayLog(QDate date);
    DayLog* getTodayLog();
    const SerializableHash<Food> *getFood() const;
    void addFood(Food* food);
    Q_INVOKABLE void addFood(const QVariantMap& data);

private: // members
    AppData* _data;
    QFile* _dataFile;

private: // methods
    void load();
    void save();

signals:

public slots:
};

#endif // DATAMANAGER_H
