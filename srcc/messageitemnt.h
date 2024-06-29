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

    Q_PROPERTY(QString content READ GetContent WRITE SetContent FINAL);
    Q_PROPERTY(QString sender READ GetSender WRITE SetSender FINAL);
    Q_PROPERTY(QString roomid READ GetRoomid WRITE SetRoomid FINAL);
    Q_PROPERTY(QString roomname READ GetRoomname WRITE SetRoomname FINAL);
    Q_PROPERTY(QString eventid READ GetEventid WRITE SetEventid FINAL);
    Q_PROPERTY(QString mtimemsui READ GetMtimemsui WRITE SetMtimemsui FINAL);
        Q_PROPERTY(int index READ GetIndex WRITE SetIndex FINAL);
    QML_ELEMENT;
public:
    QString Content;
    QString GetContent() const;
    void SetContent(QString s);
    QString Sender;
    QString GetSender() const;
    void SetSender(QString s);
    QString Roomid;
    QString GetRoomid() const;
    void SetRoomid(QString s);
    QString Roomname;
    QString GetRoomname() const;
    void SetRoomname(QString s);
    QString Eventid;
    QString GetEventid() const;
    void SetEventid(QString s);
    QString Mtimemsui;
    QString GetMtimemsui() const;
    void SetMtimemsui(QString s);

    int Index;
    int GetIndex() const;
    void SetIndex(int s);

public:
    MessageItemnt(QQuickItem* parent = nullptr);
    ~MessageItemnt();

    void paint(QPainter *painter) override;

};

#endif// _MESSAGE_ITEMNT_H_
