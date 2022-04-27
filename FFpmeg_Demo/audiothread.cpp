#include "audiothread.h"
#include  <QDebug>
#include <QFile>
extern "C" {
// 设备相关API
#include <libavdevice/avdevice.h>
// 格式相关API
#include <libavformat/avformat.h>
// 工具相关API（比如错误处理）
#include <libavutil/avutil.h>
// 编码相关API
#include <libavcodec/avcodec.h>
}

#ifdef Q_OS_WIN
    // 格式名称
    #define FMT_NAME "dshow"
    // 设备名称
    #define DEVICE_NAME "audio=麦克风 (USBAudio2.0)"
#else
    #define FMT_NAME "avfoundation"
    #define DEVICE_NAME ":4"
#endif



#ifdef Q_OS_WIN    // PCM文件的文件名
#define FILENAME "E:/out.pcm"
#else
#define FILENAME "/Users/xdf_yanqing/Downloads/out.pcm"
#endif

// 从AVFormatContext中获取录音设备的相关参数
void showSpec(AVFormatContext *ctx) {
    // 获取输入流
    AVStream *stream = ctx->streams[0];
    // 获取音频参数
    AVCodecParameters *params = stream->codecpar;
    // 声道数
    qDebug() << "channels"<<params->channels;
    // 采样率
    qDebug() <<"sample_rate"<< params->sample_rate;
    // 采样格式
    qDebug() <<"format"<< params->format;
    // 每一个样本的一个声道占用多少个字节
    qDebug() << "av_get_bytes_per_sample"<<av_get_bytes_per_sample((AVSampleFormat) params->format);
    // 编码ID（可以看出采样格式）
    qDebug() << "codec_id"<<params->codec_id;
    // 每一个样本的一个声道占用多少位（这个函数需要用到avcodec库）
    qDebug() <<"av_get_bits_per_sample"<<av_get_bits_per_sample(params->codec_id);
}

AudioThread::AudioThread(QObject *parent):QThread(parent)
{
    connect(this,&AudioThread::finished,this,&AudioThread::deleteLater);

}

AudioThread::~AudioThread()
{
    requestInterruption();
    quit();
    wait();
    qDebug() << "销毁AudioThread";
}

void AudioThread::run()
{
    AVInputFormat *fmt = av_find_input_format(FMT_NAME);
    if (!fmt) {
        // 如果找不到输入格式
        qDebug() << "找不到输入格式" << FMT_NAME;
        return;
    }

    // 格式上下文（后面通过格式上下文操作设备）
    AVFormatContext *ctx = nullptr;
    // 打开设备
    int ret = avformat_open_input(&ctx, DEVICE_NAME, fmt, nullptr);
    // 如果打开设备失败
    if (ret < 0) {
        char errbuf[1024] = {0};
        // 根据函数返回的错误码获取错误信息
        av_strerror(ret, errbuf, sizeof (errbuf));
        qDebug() << "打开设备失败" << errbuf;
        return;
    }

    // 文件
    QFile file(FILENAME);
    // WriteOnly：只写模式。如果文件不存在，就创建文件；如果文件存在，就删除文件内容
    if (!file.open(QFile::WriteOnly)) {
        qDebug() << "文件打开失败" << FILENAME;
        // 关闭设备
        avformat_close_input(&ctx);
        return;
    }

    showSpec(ctx);
    // 暂时假定只采集50个数据包
    // 数据包
    AVPacket *pkt = av_packet_alloc();
    while ( !isInterruptionRequested() && av_read_frame(ctx, pkt) == 0) {
        // 从设备中采集数据，返回值为0，代表采集数据成功
        // 读取成功        // 将数据写入文件
        file.write((const char *) pkt->data, pkt->size);
//        if (ret == 0) {


//            // 释放资源
//            av_packet_unref(pkt);
//        } else if (ret == AVERROR(EAGAIN)) {
//            // 资源临时不可用
//            continue;
//        } else {
//            // 其他错误
//            char errbuf[1024];
//            av_strerror(ret, errbuf, sizeof (errbuf));
//            qDebug() << "av_read_frame error" << errbuf << ret;
//            break;
//        }
    }
    // 关闭文件
    file.close();

    // 释放资源
    av_packet_free(&pkt);

    // 关闭设备
    avformat_close_input(&ctx);

    qDebug() << "record end";

}

void AudioThread::stop()
{
       _stop = true;
}


//播放录制的PCM数据
/* Mac
 *使用自带麦克风录制数据播放命令:
 *ffplay -sample_rate 48000 -channels 1 -f f32le  out.pcm
 *
 *Windows
 *ffplay -ar 44100 -ac 2 -f s16le out.pcm
 */
