#ifndef INGREDIENT_H
#define INGREDIENT_H

#include <QObject>

class Ingredient : public QObject
{
    Q_OBJECT
public:
    explicit Ingredient(QObject *parent = 0);

signals:

public slots:
};

#endif // INGREDIENT_H