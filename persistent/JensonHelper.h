#ifndef JENSONHELPER_H
#define JENSONHELPER_H

#include <QFile>
#include "jenson.h"

#define STANDARD_GETSET(TYPE, MEMBERNAME) \
    private: TYPE _##MEMBERNAME; \
    public: \
    TYPE MEMBERNAME() const { \
        return _##MEMBERNAME; \
    }; \
    void set##MEMBERNAME(TYPE value) { \
        _##MEMBERNAME = value; \
    }

// Convenience macro for POCO objects
#define STANDARD_PROPERTY_GETSET(TYPE, MEMBERNAME) \
    Q_PROPERTY(TYPE MEMBERNAME READ MEMBERNAME WRITE set##MEMBERNAME) \
    STANDARD_GETSET(TYPE, MEMBERNAME)

#define QOBJECT_GETSET(TYPE, MEMBERNAME) \
    private: TYPE* _##MEMBERNAME = nullptr; \
    public: \
    TYPE* MEMBERNAME() const { \
        return _##MEMBERNAME; \
    }; \
    void set##MEMBERNAME(TYPE* value) { \
        if (_##MEMBERNAME != nullptr) \
        { \
            _##MEMBERNAME->deleteLater(); \
            _##MEMBERNAME = nullptr; \
        } \
        _##MEMBERNAME = value; \
        _##MEMBERNAME->setParent(this); \
    }

#define QOBJECT_PROPERTY_GETSET(TYPE, MEMBERNAME) \
    Q_PROPERTY(TYPE* MEMBERNAME READ MEMBERNAME WRITE set##MEMBERNAME) \
    QOBJECT_GETSET(TYPE, MEMBERNAME)

template <typename T>
sptr<T> deserializeFromFile(QFile* file)
{

}

#endif // JENSONHELPER_H
