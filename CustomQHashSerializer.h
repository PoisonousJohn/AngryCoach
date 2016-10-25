#ifndef CUSTOMQHASHSERIALIZER_H
#define CUSTOMQHASHSERIALIZER_H

#include <QHash>
#include <QString>
#include "jenson.h"

template<typename T>
class CustomQHashSerializer : public jenson::JenSON::CustomSerializer<QHash<QString, T>>
{
protected:
    virtual QJsonValue serializeImpl(const QHash<QString, T> *object) const override
    {
        QJsonObject retVal;
        for (auto i = object->begin(); i != object->end(); ++i)
        {
            QJsonObject valueObj = jenson::JenSON::serialize(QVariant::fromValue(i.value()));
            if (ok)
            {
                retVal.insert(i.key(), valueObj);
            }
        }
        return retVal;
    }
    virtual sptr<QHash<QString, T>> deserializeImpl(const QJsonValue *jsonValue, QString* /*unused*/) const override
    {
        sptr<T> retVal(new QHash<QString, T>());
        auto jObj = jsonValue->toObject();
        for (auto i = jObj.begin(); i != jObj.end(); ++i)
        {
            auto sPtr = jenson::JenSON::deserialize(i.value());
            retVal.get()->insert(i.key(), sPtr.release());
        }
        return retVal;
    }
};

#endif // CUSTOMQHASHSERIALIZER_H
