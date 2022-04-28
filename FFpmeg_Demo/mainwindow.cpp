#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "audiothread.h"
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    ,m_pAudioThread(nullptr)
{

     ui->setupUi(this);
     ui->pushButton_2->setEnabled(false);

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
        connect(m_pAudioThread,&AudioThread::finished,[&](){
            m_pAudioThread = nullptr;
            ui->pushButton->setEnabled(true);
            ui->pushButton_2->setEnabled(false);
         });
        ui->pushButton->setEnabled(false);
        ui->pushButton_2->setEnabled(true);
}

void MainWindow::on_pushButton_2_clicked()
{
    if (m_pAudioThread) {
        m_pAudioThread->requestInterruption();
        m_pAudioThread = nullptr;

    }
}

