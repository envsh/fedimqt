#ifndef _MYITEMDG_H_
#define _MYITEMDG_H_

#include <QtWidgets>

class Myitemdg : public QAbstractItemDelegate {
    Q_OBJECT;
public:
    Myitemdg(QObject*p);
    virtual void	paint(QPainter *painter, const QStyleOptionViewItem &option, const QModelIndex &index) const;
    virtual QSize	sizeHint(const QStyleOptionViewItem &option, const QModelIndex &index) const;
};

#endif // _MYITEMDG_H_