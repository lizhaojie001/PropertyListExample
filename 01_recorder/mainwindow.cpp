#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFile>
#include <QDebug>
extern "C" {

// 设备相关API
#include <libavdevice/avdevice.h>
// 格式相关API
#include <libavformat/avformat.h>
// 工具相关API（比如错误处理）
#include <libavutil/avutil.h>
// 编码相关API
#include <libavcodec/avcodec.h>

#include <libavutil/dict.h>

//#include <libavcodec/av
}

// 格式名称、设备名称目前暂时使用宏定义固定死
#ifdef Q_OS_WIN
// 格式名称
#define FMT_NAME "dshow"
// 设备名称
#define DEVICE_NAME "audio=麦克风阵列 (Realtek(R) Audio)"
#else
#define FMT_NAME "avfoundation"
#define DEVICE_NAME ":4"
#endif

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    ,m_pNeedClose(false)
{
    ui->setupUi(this);


    ui->toolButton->setStyleSheet ("border:none");

    // 初始化libavdevice并注册所有输入和输出设备
    avdevice_register_all();
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_BtnRecorder_clicked()
{

    //获取输入格式对象
    AVInputFormat *fmt = av_find_input_format (FMT_NAME);
    if (!fmt) {
        qDebug() << "获取格式失败";
        return;
    }
    //打开设备
    AVFormatContext* ctx = nullptr;
    const char * device_name = ":2";
    AVDictionary *options = nullptr;
    auto ret =  avformat_open_input (&ctx,device_name,fmt,&options);
    if (ret != 0) {
        char errorBuffer[1024];
        av_strerror (ret,errorBuffer,sizeof(errorBuffer));
        qDebug() << "设备打开失败";
        qDebug() << errorBuffer;
        return;
    }

    //采集数据
    AVPacket  packet ;
    av_read_frame(ctx,&packet);
    qDebug() << packet.size;

    //存储文件
    const char * filename = "/Users/xdf_yanqing/Downloads/out.pcm";
    QFile file(filename);

    if( !file.open (QIODevice::WriteOnly)) {
        //文件不存在就创建,存在就清空文件
        avformat_close_input(&ctx);
        qDebug() << "文件创建失败";
        return;
    }

    while (av_read_frame(ctx,&packet) == 0 && !m_pNeedClose) {
        file.write ((char*)packet.data,packet.size);
    }

    file.close ();
//    av_packet_free(&(&packet));
    avformat_close_input(&ctx);

}


void MainWindow::on_pushButton_clicked()
{
    this->m_pNeedClose = true;
}

