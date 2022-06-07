#ifndef VIDEOPLAYER_H
#define VIDEOPLAYER_H

#include <QObject>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>

}
class VideoPlayer : public QObject
{
    Q_OBJECT
public:
    explicit VideoPlayer(QObject *parent = nullptr);
    ~VideoPlayer();
    enum PlayState
    {
        Playing,
        Paused,
        Stoped
    };
    void play();
    void pause();
    void stop();
    PlayState state();
    int64_t getDuration();

    bool isPlaying();
    void setFile(const char * filename);
signals:
    void playStateChanged(VideoPlayer*p);
    void videoDuration(VideoPlayer*p);

private:
    int initVideoInfo();

    int initAudioInfo();

    int initDecoder(AVCodecContext**ctx, AVMediaType type , AVStream ** stream);

    void setState(PlayState state);

private:
    PlayState _state = Paused;
    const char * _filename = nullptr;
    AVStream * _aStream = nullptr, *_vStream = nullptr;

    AVFormatContext * _fmtCtx = nullptr;
    AVCodecContext * _vCodecCtx = nullptr;
    AVCodecContext * _aCodecCtx = nullptr;

    int64_t _duration;

    int _is_planar = 0;
    int _per_sample_size = 0;
    int _per_sample_frame_size = 0;
    int _imageSize = 0;


};

#endif // VIDEOPLAYER_H
