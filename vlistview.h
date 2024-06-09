#ifndef _vlistview_h_
#define _vlistview_h_

#include "ui_vlistview.h"

class vlistview : public QMainWindow {
    Q_OBJECT;
    
public:
    Ui::MainWindow ui;
    vlistview(QWidget*parent);

    void filldata();

public slots:

};

#endif  // _vlistview_h_