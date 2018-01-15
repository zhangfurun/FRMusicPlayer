//
//  MusicTool.h
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicItem;
@interface MusicTool : NSObject
/**
 *  正在播放的歌曲
 *
 */
+ (MusicItem *)playingMusic;
/**
 *  重新设置歌曲
 *
 */
+ (void)setPlayingMusic:(MusicItem *)playingMusic;

/**
 *Music
 *
 *  @return 所有歌曲
 */
+ (NSArray *)musics;

/**
 *
 *  下一首歌曲
 */
+ (MusicItem *)nextMusic;

/**
 *  上一首歌曲
 *
 */
+ (MusicItem *)previousMusic;
@end
