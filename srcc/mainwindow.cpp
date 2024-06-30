

#include <QtWidgets>
#include <QtQml>
#include <QtQuick>
#include <QQuickWidget>
#include <QQuickWindow>

#include "mainwindow.h"
#include "../ui_mainwindow.h"

class MainWindow2Data {
public:
    QQuickWidget* tabw0;
    QQuickWidget* tabw1;
    QQuickWidget* tabw2;
    QQuickWidget* tabw3;
    QQuickWidget* tabw4;
};

MainWindow2Data* mw2d = nullptr;

MainWindow2::MainWindow2(QWidget*parent) : QMainWindow(parent) {
    uiw = new Ui_MainWindow2();
    uiw->setupUi(this);
    uiw->menubar->setNativeMenuBar(false); // sofuck macos

    // 还有一种方式，使用 css 样式
    // \see https://forum.qt.io/topic/76987/completely-custom-menu-in-qtwidgets/10
    auto oldft = uiw->menu_File->font();
    auto oldsz = oldft.pixelSize();
    #ifdef Q_OS_ANDROID
    int ftval = 8;
    #else
    int ftval = 16;
    #endif
    oldft.setPixelSize(oldsz+ftval);
    uiw->menu_File->setFont(oldft);
    uiw->menu_Wndo->setFont(oldft);
    uiw->menu_Dev->setFont(oldft);
    uiw->menu_Misc->setFont(oldft);
    uiw->menu_Help->setFont(oldft);
    // uiw->menubar->setHeight(30);
    // uiw->menubar->setFont(oldft);

    mw2d = new MainWindow2Data();
    setupMenuSlots();

    auto qw = new QQuickWidget();
    mw2d->tabw0 = qw;
    uiw->tabWidget->insertTab(0, qw, "qml00");
    uiw->tabWidget->setCurrentIndex(0);

    #ifdef Q_OS_ANDROID
    const QUrl url("qrc:///mainqml/srcui/Settingui.qml");
    #else
    const QUrl url("./srcui/Settingui.qml");
    #endif
    qw->setSource(url);
}


#include "../QmlCppBridge.h"
void MainWindow2::setupMenuSlots() {

    QObject::connect(uiw->action_Next_Page, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpage\",\"Argv\":[false,\"\",0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Prev_Page, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpage\",\"Argv\":[true,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Logui, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpageidx\",\"Argv\":[3,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Aboutui, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpageidx\",\"Argv\":[4,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Room_List, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpageidx\",\"Argv\":[1,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Loginui, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpageidx\",\"Argv\":[2,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Message_List, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpageidx\",\"Argv\":[0,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});

    // dev
    QObject::connect(uiw->action_Load_Message, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"loadmsg\",\"Argv\":[\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Load_More_Older, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"fetchmore\",\"Argv\":[\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Load_More_Older_RT, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"fetchmorert\",\"Argv\":[\"\", 0]}");
            QmlCppBridge::calljs(jstr);});

    // text format
    QObject::connect(uiw->action_AutoText, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"msglst.setccfmt\",\"Argv\":[%1,\"\", 0]}");
            jstr = jstr.arg(Qt::AutoText);
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_MarkdownText, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"msglst.setccfmt\",\"Argv\":[%1,\"\", 0]}");
            jstr = jstr.arg(Qt::MarkdownText);
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_RichText, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"msglst.setccfmt\",\"Argv\":[%1,\"\", 0]}");
            jstr = jstr.arg(Qt::RichText);
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_PlanText, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"msglst.setccfmt\",\"Argv\":[%1,\"\", 0]}");
            jstr = jstr.arg(Qt::PlainText);
            QmlCppBridge::calljs(jstr);});

    // Misc
    QObject::connect(uiw->action_Scroll_Bottom, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"msglst.scrollvto\",\"Argv\":[false,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});
    QObject::connect(uiw->action_Scroll_Top, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"msglst.scrollvto\",\"Argv\":[true,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});


    QObject::connect(uiw->action_About, &QAction::triggered,
        []{ auto jstr = QString("{\"Cmd\":\"switchpageidx\",\"Argv\":[4,\"\", 0]}");
            QmlCppBridge::calljs(jstr);});

}

    // auto mw = new QMainWindow();
    // auto qw = new QQuickWidget();
    // mw->setCentralWidget(qw);
    // // mw->show();
    // qw->setSource(QUrl("./srcui/Settingui.qml"));
    // mw->show();
    // // if (true) { return app.exec(); }

// \see https://stackoverflow.com/questions/43234163/how-to-insert-qml-view-in-a-qwidget

// 还能保持GPU加速吗？
void MainWindow2::setQmlAppWindow(QQmlApplicationEngine* qmlae) {
    auto m_engine = qmlae;
    QWindow *qmlWindow = qobject_cast<QWindow*>(m_engine->rootObjects().at(0));
    QWidget *container = QWidget::createWindowContainer(qmlWindow, this);
    container->setMinimumSize(200, 200);
    container->setMaximumSize(1200, 900);
    // ui->verticalLayout->addWidget(container);
    uiw->tabWidget->insertTab(0, container, "qmlapw");
    uiw->tabWidget->setCurrentIndex(0);
}
