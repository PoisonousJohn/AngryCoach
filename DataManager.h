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

    static QDir getDataDir();

private: // members
    AppData* _data = nullptr;
    QFile* _dataFile = nullptr;
    QHash<QDate, QSharedPointer<DayLogCache>> _dayLogCache;

private: // methods
    void load();
    void save();
    void initNewSave();


public slots:
};

#endif // DATAMANAGER_H
