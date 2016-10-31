#ifndef QMLDATAPROVIDER_H
#define QMLDATAPROVIDER_H

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
    Q_INVOKABLE void addFood(const QVariantMap& data);

    // returns list of Food*
    Q_INVOKABLE QVariantList getDayLog(const QDate& date);
    Q_INVOKABLE void addFoodToLog(const QDate& date, const QString& foodId);
    QVariantList getFood();

signals:
    void foodChanged();
    void dayLogChanged(const QDate& date);

private:
    DataManager* _dataManager;
};

#endif // QMLDATAPROVIDER_H
