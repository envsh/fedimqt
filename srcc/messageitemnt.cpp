
#include <QtCore>
#include <QtGui>
#include <QtQml>
#include <QtQuick>

#include "messageitemnt.h"

// works
auto MessageItemntQmlType = qmlRegisterType<MessageItemnt>("MessageItemnt", 1, 0, "MessageItemnt");

MessageItemnt::~MessageItemnt() {
    qDebug()<<__FUNCTION__<<__LINE__<<"dtor"<<this<<(sizeof(MessageItemnt));
}

MessageItemnt::MessageItemnt(QQuickItem* parent) : QQuickPaintedItem(parent) {

}

    QString MessageItemnt::GetContent() const { return this->Content; }
    void MessageItemnt::SetContent(QString s) { this->Content = s; }
    QString MessageItemnt::GetSender() const { return Sender; }
    void MessageItemnt::SetSender(QString s) { Sender = s; }
    QString MessageItemnt::GetRoomid() const { return Roomid; }
    void MessageItemnt::SetRoomid(QString s) { Roomid = s; }
    QString MessageItemnt::GetRoomname() const { return Roomname; }
    void MessageItemnt::SetRoomname(QString s) { Roomname = s; }
    QString MessageItemnt::GetEventid() const { return Eventid; }
    void MessageItemnt::SetEventid(QString s) { Eventid = s; }
    QString MessageItemnt::GetMtimemsui() const { return Mtimemsui; }
    void MessageItemnt::SetMtimemsui(QString s) { Mtimemsui = s; }

    int MessageItemnt::GetIndex() const { return Index; }
    void MessageItemnt::SetIndex(int s) { Index = s; }

void MessageItemnt::paint(QPainter *painter) {
    // QString Content = "hehehhe Content";
    QString Roomname = "hehehhe Roomname";

    QPen pen(Qt::white);
    painter->setPen(pen);

    QSizeF wsz = size();

    painter->drawLine(0,1, wsz.width(), 1);
    painter->drawLine(0, wsz.height(), wsz.width(), wsz.height());

    painter->setOpacity(0.7);
    painter->drawText(15,15, Sender);
    painter->setOpacity(0.6);
    painter->drawText(85,15, Roomname);
    painter->setOpacity(0.5);
    painter->drawText(165,15, Roomid);
    painter->setOpacity(0.4);
    painter->drawText(255,15, Mtimemsui);
    
    QRect rect0(0,0, wsz.width()-30, 30);
    QRect ccrect = painter->boundingRect(rect0, Qt::TextWrapAnywhere, Content);
    // qDebug()<<__FUNCTION__<<__LINE__<<ccrect;
    if (height() < ccrect.height() + 50) {
        this->setHeight(ccrect.height()+50);
    }
    
    painter->setOpacity(0.9);
    painter->drawText(15,35, wsz.width()-30, ccrect.height(), Qt::TextWrapAnywhere, Content);

    // Content = "";
    // Roomid = "";

    return;

    QBrush brush(QColor("#007430"));
    painter->setBrush(brush);
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);

    QSizeF itemSize = size();
    painter->drawRoundedRect(0, 0, itemSize.width(), itemSize.height() - 10, 10, 10);

    bool rightAligned = true;
    if (rightAligned)
    {
        const QPointF points[3] = {
            QPointF(itemSize.width() - 10.0, itemSize.height() - 10.0),
            QPointF(itemSize.width() - 20.0, itemSize.height()),
            QPointF(itemSize.width() - 30.0, itemSize.height() - 10.0),
        };
        painter->drawConvexPolygon(points, 3);
    }
    else
    {
        const QPointF points[3] = {
            QPointF(10.0, itemSize.height() - 10.0),
            QPointF(20.0, itemSize.height()),
            QPointF(30.0, itemSize.height() - 10.0),
        };
        painter->drawConvexPolygon(points, 3);
    }    
}

// void TextBalloon::paint(QPainter *painter)
// {
//     QBrush brush(QColor("#007430"));

//     painter->setBrush(brush);
//     painter->setPen(Qt::NoPen);
//     painter->setRenderHint(QPainter::Antialiasing);

//     QSizeF itemSize = size();
//     painter->drawRoundedRect(0, 0, itemSize.width(), itemSize.height() - 10, 10, 10);

//     if (rightAligned)
//     {
//         const QPointF points[3] = {
//             QPointF(itemSize.width() - 10.0, itemSize.height() - 10.0),
//             QPointF(itemSize.width() - 20.0, itemSize.height()),
//             QPointF(itemSize.width() - 30.0, itemSize.height() - 10.0),
//         };
//         painter->drawConvexPolygon(points, 3);
//     }
//     else
//     {
//         const QPointF points[3] = {
//             QPointF(10.0, itemSize.height() - 10.0),
//             QPointF(20.0, itemSize.height()),
//             QPointF(30.0, itemSize.height() - 10.0),
//         };
//         painter->drawConvexPolygon(points, 3);
//     }
// }