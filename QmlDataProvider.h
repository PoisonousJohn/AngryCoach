#ifndef QMLDATAPROVIDER_H
#define QMLDATAPROVIDER_H

#include <QDate>
#include <QObject>
#include <QList>
#include <QVariant>
class DataManager;
class Food;

class QmlDataProvider : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QVariantList food READ getFood NOTIFY foodChanged)
    QmlDataProvider(QObject* parent = 0);

    Q_PROPERTY(QDate selectedDate READ getSelectedDate NOTIFY selectedDateChanged)
    Q_PROPERTY(QVariantMap userProfile READ getUserProfileModel NOTIFY userProfileChanged)

    const QDate& getSelectedDate() const;
    void setSelectedDate(const QDate& date);

    // food
    Q_INVOKABLE void addFood(const QVariantMap& data);
    Q_INVOKABLE void editFood(const QString& foodId, const QVariantMap& data);
    Q_INVOKABLE void removeFood(const QString& foodId);
    QVariantList getFood();
    Q_INVOKABLE QObject* getFoodById(const QString& foodId);

    // day log

    // returns list of Food*
    Q_INVOKABLE QVariantList getDayLog(const QDate& date);
    Q_INVOKABLE void addFoodToLog(const QDate& date, const QString& foodId, float foodAmount);
    Q_INVOKABLE void removeFoodFromLog(const QDate& date, int index);
    Q_INVOKABLE QVariantMap getFoodValuesForForm(const QString& foodId);
    Q_INVOKABLE QVariantMap getUserProfileModel();
    Q_INVOKABLE void updateUserProfile(const QVariantMap& data);


signals:
    void foodChanged();
    void dayLogChanged(const QDate& date);
    void selectedDateChanged();
    void userProfileChanged();

private: // methods
    Food* findFood(const QString& foodId);
    float getFloat(const QVariant& variant) const;
    void mapDataToFood(Food* food, const QVariantMap& data);
    QString getStringFromFloat(float value);

private: // members
    DataManager* _dataManager;
    QDate _selectedDate;
};

#endif // QMLDATAPROVIDER_H
