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
    SerializableHash(QObject* parent = 0)
        : QObject(parent)
    {

    }

    QHash<QString, T*>& getHash() {
        return _hash;
    }

    const QHash<QString, T*>& getHash() const {
        return _hash;
    }

private:
    QHash<QString, T*> _hash;
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
            QJsonObject valueObj = jenson::JenSON::serialize(i.value());
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
            retVal.get()->getHash().insert(i.key(), ptr);
        }
        return retVal;
    }
};

#endif // CUSTOMQHASHSERIALIZER_H
