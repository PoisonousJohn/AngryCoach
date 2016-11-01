#ifndef QMLDATAPROVIDER_H
#define QMLDATAPROVIDER_H

#include <QDate>
#include <QObject>
#include <QList>
#include <QVariant>
class DataManager;

class QmlDataProvider : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QVariantList food READ getFood NOTIFY foodChanged)
    QmlDataProvider(QObject* parent = 0);

    Q_PROPERTY(QDate selectedDate READ getSelectedDate NOTIFY selectedDateChanged)

    const QDate& getSelectedDate() const;
    void setSelectedDate(const QDate& date);

    // food
    Q_INVOKABLE void addFood(const QVariantMap& data);
    Q_INVOKABLE void removeFood(const QString& foodId);
    QVariantList getFood();
    Q_INVOKABLE QObject* getFoodById(const QString& foodId);

    // day log

    // returns list of Food*
    Q_INVOKABLE QVariantList getDayLog(const QDate& date);
    Q_INVOKABLE void addFoodToLog(const QDate& date, const QString& foodId, float foodAmount);
    Q_INVOKABLE void removeFoodFromLog(const QDate& date, int index);


signals:
    void foodChanged();
    void dayLogChanged(const QDate& date);
    void selectedDateChanged();

private:
    DataManager* _dataManager;
    QDate _selectedDate;
};

#endif // QMLDATAPROVIDER_H
