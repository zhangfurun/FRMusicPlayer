//
//  LrcImageView.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "LrcImageView.h"

#import "LrcCell.h"

#import "LrcLineItem.h"

#import "UIView+AutoLayout.h"

@interface LrcImageView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *lrcLines;
/**
 *  记录当前显示歌词在数组里面的index
 */
@property (nonatomic, assign) int currentIndex;
@end

@implementation LrcImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(self.frame.size.height / 2, 0, self.frame.size.height / 2, 0);
}

#pragma mark - Init Methods
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    self.userInteractionEnabled = YES;
    self.image = [UIImage imageNamed:@"28131977_1383101943208"];
    self.contentMode = UIViewContentModeScaleToFill;
    self.clipsToBounds = YES;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    [self addSubview:tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark - Get Or Set Methods
- (NSMutableArray *)lrcLines {
    if (_lrcLines == nil) {
        _lrcLines = [LrcLineItem lrcLinesWithFileName:self.fileName];
    }
    return _lrcLines;
}

- (void)setFileName:(NSString *)fileName {
    if ([_fileName isEqualToString:fileName]) {
        return;
    }
    _fileName = [fileName copy];
    [_lrcLines removeAllObjects];
    _lrcLines = nil;
    [self.tableView reloadData];
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    if (_currentTime > currentTime) {
        self.currentIndex = 0;
    }
    _currentTime = currentTime;
    
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d", minute, second, msecond];
    
    for (int i = self.currentIndex; i < self.lrcLines.count; i++) {
        LrcLineItem *currentLine = self.lrcLines[i];
        NSString *currentLineTime = currentLine.time;
        NSString *nextLineTime = nil;
        
        if (i + 1 < self.lrcLines.count) {
            LrcLineItem *nextLine = self.lrcLines[i + 1];
            nextLineTime = nextLine.time;
        }
        
        if (([currentTimeStr compare:currentLineTime] != NSOrderedAscending) && ([currentTimeStr compare:nextLineTime] == NSOrderedAscending) && (self.currentIndex != i)) {
            NSArray *reloadLines = @[
                                     [NSIndexPath indexPathForItem:self.currentIndex inSection:0],
                                     [NSIndexPath indexPathForItem:i inSection:0]
                                     ];
            self.currentIndex = i;
            [self.tableView reloadRowsAtIndexPaths:reloadLines withRowAnimation:UITableViewRowAnimationNone];
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LrcCell *cell = [LrcCell lrcCellWithTableView:tableView];
    cell.lrcLine = self.lrcLines[indexPath.row];
    
    if (indexPath.row == self.currentIndex) {
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    else{
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    return cell;
}

@end

