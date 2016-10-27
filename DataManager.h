#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QHash>
#include <QDate>
#include <QFile>
#include <QDir>
#include <QSharedPointer>
#include "CustomQHashSerializer.h"
#include "DayLogCache.h"

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
    Q_PROPERTY(QObject* todayLog READ getTodayLog)

    Q_INVOKABLE QObject* getDayLog(const QDate& date);
    QObject* getTodayLog();
    QObject* food();
    FoodMap* getFood();
    void addFood(Food* food);
    Q_INVOKABLE void addFood(const QVariantMap& data);

    static QDir getDataDir();

private: // members
    AppData* _data = nullptr;
    QFile* _dataFile = nullptr;
    QHash<QDate, QSharedPointer<DayLogCache>> _dayLogCache;

private: // methods
    void load();
    void save();
    void initNewSave();

signals:

    void foodChanged();

public slots:
};

#endif // DATAMANAGER_H
