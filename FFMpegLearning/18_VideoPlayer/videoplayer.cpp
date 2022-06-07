#include "videoplayer.h"
#include <QDebug>

extern "C"{
#include <libavutil/imgutils.h>
}

#define ERROR_BUF \
char errbuf[1024]; \
    av_strerror(ret, errbuf, sizeof (errbuf));

#define END(func) \
if (ret < 0) { \
        ERROR_BUF; \
        qDebug() << #func << "error" << errbuf; \
        goto end; \
}

#define RET(func) \
if (ret < 0) { \
        ERROR_BUF; \
        qDebug() << #func << "error" << errbuf; \
        return ret; \
}

VideoPlayer::VideoPlayer(QObject *parent)
    : QObject{parent}
{

}

VideoPlayer::~VideoPlayer()
{

}


void VideoPlayer::play()
{
  if (isPlaying()) return;
  setState(Playing);

  int ret = 0;
  AVPacket pkt;


  // 创建解封装上下文、打开文件
  ret = avformat_open_input(&_fmtCtx, _filename, nullptr, nullptr);
  END(avformat_open_input);

  // 检索流信息
  ret = avformat_find_stream_info(_fmtCtx, nullptr);
  END(avformat_find_stream_info);

  // 打印流信息到控制台
  av_dump_format(_fmtCtx, 0, _filename, 0);
  fflush(stderr);

  _duration = _fmtCtx->duration;
  emit videoDuration(this);
  //初始化视频模块
  ret = initVideoInfo();
  END(initVideoInfo);

  //初始化音频模块
  ret = initAudioInfo();
  END(initAudioInfo);


  //读取数据
  while (av_read_frame(_fmtCtx,&pkt) == 0) {
      if(pkt.stream_index == _aStream->index) {

      } else if(pkt.stream_index == _vStream->index) {
      }

  }

end:


    avcodec_close(_aCodecCtx);
    avcodec_close(_vCodecCtx);
    avformat_close_input(&_fmtCtx);


}

void VideoPlayer::pause()
{
    if (!isPlaying()) return;
   setState(Paused);

}

void VideoPlayer::stop()
{
    setState(Stoped);

}

VideoPlayer::PlayState VideoPlayer::state()
{
    return _state;
}

int64_t VideoPlayer::getDuration()
{
    return  _duration;
}

bool VideoPlayer::isPlaying()
{
    return _state == Playing;
}

void VideoPlayer::setFile(const char *filename)
{
    _filename = filename;

}

int VideoPlayer::initVideoInfo()
{
    int ret = 0;
    ret = initDecoder(&_vCodecCtx,AVMEDIA_TYPE_VIDEO,&_vStream);

    //一帧大小
    _imageSize = av_image_get_buffer_size(_vCodecCtx->pix_fmt,_vCodecCtx->width,_vCodecCtx->height,1);

    return ret;
}

int VideoPlayer::initAudioInfo()
{
    initDecoder(&_aCodecCtx,AVMEDIA_TYPE_AUDIO,&_aStream);

    //计算单声道采样数据大小
    _per_sample_size = av_get_bytes_per_sample(_aCodecCtx->sample_fmt);
    _per_sample_frame_size = _per_sample_size * _aCodecCtx->ch_layout.nb_channels;
    //是否是planar
    _is_planar = av_sample_fmt_is_planar(_aCodecCtx->sample_fmt);
    qDebug() << "_is_planar:  " << _is_planar;

    return 0;
}

int VideoPlayer::initDecoder(AVCodecContext **ctx, AVMediaType type, AVStream **stream)
{
    //从流信息中获取数据
    int ret = av_find_best_stream(_fmtCtx,type,-1,-1,nullptr,0);
    RET(ret);
    int streamIndex = ret;
    //获取stream
    *stream = _fmtCtx->streams[streamIndex];
    if(!(*stream)) {
        qDebug() << " _fmtCtx->streams[ret] error";
        return -1;
    }
    //找到对应的解码器
    const AVCodec * decoder = avcodec_find_decoder((*stream)->codecpar->codec_id);
    if(!decoder) {
        qDebug() << "avcodec_find_decoder error";
        return -1;
    }
    //创建解码器上下文
    *ctx = avcodec_alloc_context3(decoder);
    if (!*ctx) {
        qDebug() << "avcodec_alloc_context3 error";
        return -1;
    }
    // 从输入流中copy参数到解码器上下文
    ret = avcodec_parameters_to_context(*ctx,(*stream)->codecpar);
    RET(avcodec_parameters_to_context);

    //打开解码器
    ret = avcodec_open2(*ctx,decoder,nullptr);
    RET(avcodec_open2);


    return 0;

}

void VideoPlayer::setState(PlayState state)
{
    _state = state;
    emit playStateChanged(this);
}
