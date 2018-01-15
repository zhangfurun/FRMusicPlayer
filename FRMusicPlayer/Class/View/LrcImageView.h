//
//  LrcImageView.h
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LrcImageView : UIImageView
@property (nonatomic, copy  ) NSString *fileName;
@property (nonatomic, assign) NSTimeInterval currentTime;
@end
