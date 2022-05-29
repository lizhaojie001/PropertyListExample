#include "yuvplayer.h"
#include "ffmpegs.h"
#include <QPainter>
// 出错了就执行goto RET
#define RET(judge, func) \
if (!judge) { \
        qDebug() << #func << "Error" << SDL_GetError(); \
        return; \
}

extern "C" {
    #include <libavutil/imgutils.h>
}




YUVplayer::YUVplayer(QWidget *parent)
    : QWidget{parent}
{


}

YUVplayer::~YUVplayer()
{
    _file.close();

}

void YUVplayer::play()
{

    _timerId = startTimer(1000/_yuv.fps);
    _state = ::isPlaying;

}

void YUVplayer::pause()
{
    killTimer(_timerId);
    _state = ::isPaused;

}

void YUVplayer::stop()
{
    killTimer(_timerId);
    _state = ::isStoped;
}

YUVPlayState YUVplayer::state()
{
    return _state;
}

void YUVplayer::setYUV(YUV yuv)
{
    _yuv = yuv;
    _file.setFileName(yuv.filename);
    if(!_file.open(QFile::ReadOnly)){
        qDebug() << "file open error";
        return;
    }

}

void YUVplayer::timerEvent(QTimerEvent *event)
{

    long  imageSize = av_image_get_buffer_size(_yuv.fmt,
                                              _yuv.size.width(),
                                              _yuv.size.height(),1);
    char data[imageSize];
    int len = _file.read(data,imageSize);
    if(len > 0) {
        RawVideoFrame in = {
            data,
            _yuv.size.width(),
            _yuv.size.height(),
            AV_PIX_FMT_YUV420P
        };
        RawVideoFrame out = {
            nullptr,
            _yuv.size.width(),
            _yuv.size.height(),
            AV_PIX_FMT_RGB24
        };

        FFmpegs::transformFile(in,out);
        _image = new QImage((uchar *)out.pixels,_yuv.size.width(),_yuv.size.height(),QImage::Format_RGB888);
        update();
    }else{
        killTimer(_timerId);
        _state = ::isStoped;
        emit yuvPalyEnd();
        _file.close();
        setYUV(_yuv);
    }
}


void YUVplayer::paintEvent(QPaintEvent *event)
{
    if(!_image) return;
    QPainter painter(this);
    painter.drawImage(QRect(0,0,this->width(),this->height()),*_image);
}
