#include "audioresamplethread.h"
#include <QDebug>
#include "CommonDefine.h"
#include <QFile>
extern "C" {
#include <libavutil/avutil.h>
#include <libswresample/swresample.h>
}
AudioReSampleThread::AudioReSampleThread(QObject *parent)
    : QThread{parent}
{
    connect(this,&AudioReSampleThread::finished,this,&AudioReSampleThread::deleteLater);
}

AudioReSampleThread::~AudioReSampleThread()
{
    requestInterruption();
    wait();
    quit();
    qDebug() << "AudioReSampleThread" << "析构";
}


void AudioReSampleThread::run()
{

    QString outFilename = OUTPCMFILENAME;
    QFile out_file(outFilename);
    QString intFilename = FILENAME;
    QFile in_file(intFilename);
#ifdef Q_OS_WIN
    int out_ch_layout = AV_CH_LAYOUT_MONO;
    AVSampleFormat out_sample_format  = AV_SAMPLE_FMT_FLT;
    int out_sample_rate = 48000;

    uint8_t ** out_audio_data = nullptr;
    int out_linesize = 0;
    int out_nb_channels = av_get_channel_layout_nb_channels(out_ch_layout);
    int out_nb_samples = 1024;
    int out_align = 1;

    int in_ch_layout = AV_CH_LAYOUT_STEREO;
    AVSampleFormat in_sample_format = AV_SAMPLE_FMT_S16;
    int in_sample_rate = 44100;
    int out_bytes_per_sample = av_get_bytes_per_sample(out_sample_format) * out_nb_channels;
    uint8_t ** in_audio_data = nullptr;
    int in_linesize = 0;
    int in_nb_channels = av_get_channel_layout_nb_channels(in_ch_layout);
    int in_nb_samples = 1024;
    int in_align = 1;

#else

     //创建上下文
    int out_ch_layout = AV_CH_LAYOUT_MONO;
    AVSampleFormat out_sample_format  = AV_SAMPLE_FMT_S16;
    int out_sample_rate = 44100;

    uint8_t ** out_audio_data = nullptr;
    int out_linesize = 0;
    int out_nb_channels = av_get_channel_layout_nb_channels(out_ch_layout);
    int out_nb_samples = 1024;
    int out_align = 1;

    int in_ch_layout = AV_CH_LAYOUT_MONO;
    AVSampleFormat in_sample_format = AV_SAMPLE_FMT_FLT;
    int in_sample_rate = 48000;
    int out_bytes_per_sample = av_get_bytes_per_sample(out_sample_format) * out_nb_channels;
    uint8_t ** in_audio_data = nullptr;
    int in_linesize = 0;
    int in_nb_channels = av_get_channel_layout_nb_channels(in_ch_layout);
    int in_nb_samples = 1024;
    int in_align = 1;
#endif

    SwrContext  *cxt = swr_alloc_set_opts(nullptr,
                                          out_ch_layout,
                                          out_sample_format,
                                          out_sample_rate,
                                          in_ch_layout,
                                          in_sample_format,
                                          in_sample_rate,
                                          0,
                                          nullptr);

     int ret = 0;
     int len = 0;

    if(!cxt) {
        qDebug() << "swr_alloc_set_opts error";
        goto end;

    }
    //初始化上下文
   ret = swr_init(cxt);

   if(ret < 0) {
       ERROR(ret)
       qDebug() << "swr_init error " << errbuf ;
      goto end;
   }

   //创建输出缓冲区

   ret = av_samples_alloc_array_and_samples(&out_audio_data,&out_linesize,out_nb_channels,out_nb_samples,out_sample_format,out_align);
    if(ret < 0) {
        ERROR(ret);
        qDebug() << "av_samples_alloc_array_and_samples" << errbuf;
        goto end;
    }

    //创建输入缓冲区

    ret = av_samples_alloc_array_and_samples(&in_audio_data,&in_linesize,in_nb_channels,in_nb_samples,in_sample_format,in_align);
     if(ret < 0) {
         ERROR(ret);
         qDebug() << "av_samples_alloc_array_and_samples" << errbuf;
         goto end;
     }


     //打开文件
     if(!out_file.open(QFile::WriteOnly)) {
         qDebug() << "out_file open error";
         goto end;
     }

     if(!in_file.open(QFile::ReadOnly)) {
         qDebug() << "out_file open error";
         goto end;
     }

     while ((len = in_file.read((char *)in_audio_data[0],in_linesize)) > 0) {
         int in_count = len / (av_get_bytes_per_sample(in_sample_format) * in_nb_channels);
         //放回采样数量
         ret = swr_convert(cxt,out_audio_data,out_nb_samples,
                           (const uint8_t**)in_audio_data,in_count);
         if(ret < 0) {
             ERROR(ret)
                     qDebug()<< "swr_convert error" << errbuf;
             goto end;
         }

         out_file.write((char *)out_audio_data[0],ret * out_bytes_per_sample);
     }



 end:
     //资源释放
     out_file.close();
     in_file.close();
     if(out_audio_data){
      av_freep(&out_audio_data[0]);
     }
     av_freep(&out_audio_data);
     if (in_audio_data) {
             av_freep(&in_audio_data[0]);
     }
    av_freep(&in_audio_data);
     swr_free(&cxt);

}
