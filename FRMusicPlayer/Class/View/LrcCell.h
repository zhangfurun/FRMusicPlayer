//
//  LrcCell.h
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const LrcCell_ID ;

@class LrcLineItem;
@interface LrcCell : UITableViewCell
@property (nonatomic, strong) LrcLineItem *lrcLine;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;
@end
