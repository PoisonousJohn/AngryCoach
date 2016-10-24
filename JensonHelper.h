#ifndef JENSONHELPER_H
#define JENSONHELPER_H

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

#endif // JENSONHELPER_H
