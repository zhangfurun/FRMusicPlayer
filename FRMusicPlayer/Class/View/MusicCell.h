//
//  MusicCell.h
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MusicCell_ID;

@class MusicItem;

@interface MusicCell : UITableViewCell
@property (nonatomic, strong) MusicItem *musicItem;

+ (instancetype)musicCellWithTableView:(UITableView *)tableView;
@end

