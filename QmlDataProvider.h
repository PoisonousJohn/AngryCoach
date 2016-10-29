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
    Q_INVOKABLE QObject* getDayLog(const QDate& date);
    QVariantList getFood();

signals:
    void foodChanged();

private:
    DataManager* _dataManager;
};

#endif // QMLDATAPROVIDER_H
