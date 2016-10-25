#ifndef CUSTOMQHASHSERIALIZER_H
#define CUSTOMQHASHSERIALIZER_H

#include <QHash>
#include <QObject>
#include <QString>
#include "jenson.h"

template <typename T>
class SerializableHash : public QObject
{
public:
    typedef T Item;
    typedef T* ItemPtr;
    typedef QVariantMap Hash;
    SerializableHash(QObject* parent = 0)
        : QObject(parent)
    {

    }

    virtual void insert(QString key, ItemPtr item)
    {
       _hash.insert(key, QVariant::fromValue(item));
    }


    Hash* getHashQML() {
        return &_hash;
    }

    Hash& getHash() {
        return _hash;
    }

    Q_INVOKABLE const Hash& getHash() const {
        return _hash;
    }

private:
    Hash _hash;
};

template<typename T>
class CustomQHashSerializer : public jenson::JenSON::CustomSerializer<T>
{
protected:
    virtual QJsonValue serializeImpl(const T *object) const override
    {
        auto hash = object->getHash();
        QJsonObject retVal;
        for (auto i = hash.begin(); i != hash.end(); ++i)
        {
            QJsonObject valueObj = jenson::JenSON::serialize(
                        qvariant_cast<typename T::ItemPtr>(i.value())
            );
            retVal.insert(i.key(), valueObj);
        }
        return retVal;
    }
    virtual sptr<T> deserializeImpl(const QJsonValue *jsonValue, QString* /*unused*/) const override
    {
        sptr<T> retVal(new T());
        auto jObj = jsonValue->toObject();
        for (auto i = jObj.begin(); i != jObj.end(); ++i)
        {
            auto valueObj = i.value().toObject();
            auto sPtr = jenson::JenSON::deserialize<typename T::Item>(&valueObj);
            auto ptr = sPtr.release();
            retVal.get()->insert(i.key(), ptr);
        }
        return retVal;
    }
};

#endif // CUSTOMQHASHSERIALIZER_H
