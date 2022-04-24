#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "audiothread.h"
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    ,m_pAudioThread(nullptr)
{

     ui->setupUi(this);

}

MainWindow::~MainWindow()
{

    delete ui;
}


void MainWindow::on_pushButton_clicked()
{
    if (!m_pAudioThread) {
        m_pAudioThread = new AudioThread(this);
    }
        m_pAudioThread->start ();
}

void MainWindow::on_pushButton_2_clicked()
{
    if (m_pAudioThread) {
//        m_pAudioThread->stop();
        m_pAudioThread->requestInterruption();
        m_pAudioThread = nullptr;
    }
}

