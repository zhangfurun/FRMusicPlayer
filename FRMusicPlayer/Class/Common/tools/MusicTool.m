//
//  MusicTool.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "MusicTool.h"

#import "MusicItem.h"

#import "MJExtension.h"

static NSArray *_musics;
static MusicItem *_playingMusic;

@implementation MusicTool

+ (NSArray *)musics {
    if (_musics == nil) {
        _musics = [MusicItem objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

+ (MusicItem *)playingMusic {
    return _playingMusic;
}

+ (void)setPlayingMusic:(MusicItem *)playingMusic {
    if (playingMusic == nil || ![_musics containsObject:playingMusic] || playingMusic == _playingMusic) {
        return;
    }
    _playingMusic = playingMusic;
}


+ (MusicItem *)nextMusic {
    int nextIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[[self musics] indexOfObject:_playingMusic];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    return [self musics][nextIndex];
}

+ (MusicItem *)previousMusic {
    int previousIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[[self musics] indexOfObject:_playingMusic];
        previousIndex = playingIndex - 1;
        if (previousIndex < 0) {
            previousIndex = (int)[self musics].count - 1;
        }
    }
    return [self musics][previousIndex];
}
@end
