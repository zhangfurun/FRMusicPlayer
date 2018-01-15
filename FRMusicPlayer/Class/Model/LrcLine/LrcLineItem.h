//
//  LrcLineItem.h
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicItem;

@interface LrcLineItem : NSObject
/**
 *  时间点
 */
@property (nonatomic, copy) NSString *time;
/**
 *  词
 */
@property (nonatomic, copy) NSString *word;
/**
 *  返回所有的歌词model
 *
 */
+ (NSMutableArray *)lrcLinesWithFileName:(NSString *)fileName;
@end
