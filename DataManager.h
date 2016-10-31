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

    DayLog* getDayLog(const QDate& date);
    FoodMap* getFood();
    void addFood(Food* food);
    void addFood(const QVariantMap& data);
    void addFoodToLog(const QDate& date, const QString& foodId);
    void removeFoodFromLog(const QDate& date, int index);

    static QDir getDataDir();

private: // members
    AppData* _data = nullptr;
    QFile* _dataFile = nullptr;
    QHash<QDate, QSharedPointer<DayLogCache>> _dayLogCache;

private: // methods
    void load();
    void save();
    void initNewSave();
    QSharedPointer<DayLogCache> getDayLogCache(const QDate& date);


public slots:
    void saveDayLog(const QDate& date);
};

#endif // DATAMANAGER_H
