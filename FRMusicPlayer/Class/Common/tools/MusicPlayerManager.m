//
//  MusicPlayerManager.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "MusicPlayerManager.h"

#import <AVFoundation/AVFoundation.h>

static MusicPlayerManager *_instance = nil;

@interface MusicPlayerManager ()
@property (nonatomic, strong) NSMutableDictionary *musicPlayers;
@property (nonatomic, strong) NSMutableDictionary *soundIDs;
@end

@implementation MusicPlayerManager

+ (void)initialize {
    // 音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型（播放类型、播放模式,会自动停止其他音乐的播放）
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 激活会话
    [session setActive:YES error:nil];
}

#pragma mark - Methods
- (NSMutableDictionary *)musicPlayers {
    if (!_musicPlayers) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}

- (NSMutableDictionary *)soundIDs {
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MusicPlayerManager alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - Music Control
//播放音乐
- (AVAudioPlayer *)playingMusic:(NSString *)filename {
    if (filename == nil || filename.length == 0)  return nil;
    
    //先查询对象是否缓存了
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    if (!player) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url)  return nil;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        if (![player prepareToPlay]) return nil;
        
        //对象是最新创建的，那么对它进行一次缓存
        self.musicPlayers[filename] = player;
    }
    
    //如果没有正在播放，那么开始播放，如果正在播放，那么不需要改变什么
    if (![player isPlaying]) {
        [player play];
    }
    return player;
}

// 暂停
- (void)pauseMusic:(NSString *)filename {
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    if ([player isPlaying]) {
        [player pause];
    }
}

// 停止
- (void)stopMusic:(NSString *)filename {
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    [player stop];
    
    [self.musicPlayers removeObjectForKey:filename];
}

//播放音效
- (void)playSound:(NSString *)filename {
    if (!filename) return;
    
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        self.soundIDs[filename] = @(soundID);
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID);
}

//摧毁音效
- (void)disposeSound:(NSString *)filename {
    if (!filename) return;
    
    
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [self.soundIDs removeObjectForKey:filename];    //音效被摧毁，那么对应的对象应该从缓存中移除
    }
}

@end
