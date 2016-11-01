#include <QDebug>
#include "Food.h"

Food::Food(QObject *parent) : QObject(parent)
{

}

Food::~Food()
{
    qDebug() << "~Food()";
}
