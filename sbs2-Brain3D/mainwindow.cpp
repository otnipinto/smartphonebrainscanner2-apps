#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent)
{

    glwidget = new GLWidget();
    //glwidget->showFullScreen();
    glwidget->show();
    close();
}
