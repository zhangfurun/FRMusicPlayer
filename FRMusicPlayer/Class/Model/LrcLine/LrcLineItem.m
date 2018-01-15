//
//  LrcLineItem.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "LrcLineItem.h"

#import "MusicItem.h"

@implementation LrcLineItem
+ (NSMutableArray *)lrcLinesWithFileName:(NSString *)fileName; {
    NSMutableArray *lrcLines = [NSMutableArray array];
    //    NSLog(@"%@",fileName);
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    NSString *lrcStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //分割字符串，以换行符进行分割，将一句句歌词单独分割出来
    NSArray *lrcCmps = [lrcStr componentsSeparatedByString:@"\n"];
    
    [lrcCmps enumerateObjectsUsingBlock:^(NSString *lineStr, NSUInteger idx, BOOL * _Nonnull stop) {
        LrcLineItem *lrcLine = [[LrcLineItem alloc] init];
        [lrcLines addObject:lrcLine];
        
        // 如果是歌词的头部信息（歌名、歌手、专辑）
        if ([lineStr hasPrefix:@"[ti:"] || [lineStr hasPrefix:@"[ar:"] || [lineStr hasPrefix:@"[al:"] ) {
            NSString *word = [[lineStr componentsSeparatedByString:@":"] lastObject];
            lrcLine.word = [word substringToIndex:word.length - 1];
        } else if ([lineStr hasPrefix:@"["]) { // 非头部信息
            NSArray *array = [lineStr componentsSeparatedByString:@"]"];
            lrcLine.time = [[array firstObject] substringFromIndex:1];
            lrcLine.word = [array lastObject];
        }
    }];
    if (lrcLines.count == 0) {
        return nil;
    }else{
        return lrcLines;
    }
}

@end
