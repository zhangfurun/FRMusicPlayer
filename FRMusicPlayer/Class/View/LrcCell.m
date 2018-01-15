//
//  LrcCell.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "LrcCell.h"

#import "LrcLineItem.h"

NSString * const LrcCell_ID = @"LrcCell_ID";

@implementation LrcCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.bounds = self.bounds;
}

#pragma mark - Methods
+ (instancetype)lrcCellWithTableView:(UITableView *)tableView {
    LrcCell *cell = [tableView dequeueReusableCellWithIdentifier:LrcCell_ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LrcCell_ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:LrcCell_ID]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.numberOfLines = 0;
    }
    return self;
}

- (void)setLrcLine:(LrcLineItem *)lrcLine {
    _lrcLine = lrcLine;
    self.textLabel.text = lrcLine.word;
}

@end
