#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QHash>
#include <QDate>
#include <QUuid>
#include <QFile>
#include "CustomQHashSerializer.h"
class DayLog;
class Food;
class AppData;
class FoodMap;

class DataManager : public QObject
{
    Q_OBJECT
public:
    explicit DataManager(QObject *parent = 0);

    Q_PROPERTY(QObject* food READ food NOTIFY foodChanged)

    DayLog* getDayLog(QDate date);
    DayLog* getTodayLog();
    QObject* food();
    FoodMap* getFood();
    void addFood(Food* food);
    Q_INVOKABLE void addFood(const QVariantMap& data);


private: // members
    AppData* _data = nullptr;
    QFile* _dataFile = nullptr;

private: // methods
    void load();
    void save();
    void initNewSave();

signals:

    void foodChanged();

public slots:
};

#endif // DATAMANAGER_H
