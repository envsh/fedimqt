#ifndef _MESSAGE_ITEMNT_H_
#define _MESSAGE_ITEMNT_H_

class QPainter;
class QQuickItem;
// class QQuickPaintedItem;
// #include <QObject>
// #include <QtQml>
// #include <QtQuick>
#include <QQuickPaintedItem>

// \see https://doc.qt.io/qt-6/qtquick-customitems-painteditem-example.html

class MessageItemnt : public QQuickPaintedItem
{
    Q_OBJECT;
    // property heere
    QML_ELEMENT;

public:
    MessageItemnt(QQuickItem* parent = nullptr);
    ~MessageItemnt();

    void paint(QPainter *painter) override;

};

#endif// _MESSAGE_ITEMNT_H_
