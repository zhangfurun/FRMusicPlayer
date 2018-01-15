//
//  MusicCell.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "MusicCell.h"

#import "MusicItem.h"

#import "Colours.h"
#import "ImageTool.h"

NSString * const MusicCell_ID = @"MusicCell_ID";

@implementation MusicCell

#pragma mark - Methods
+ (instancetype)musicCellWithTableView:(UITableView *)tableView {
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:MusicCell_ID];
    if (cell == nil) {
        cell = [[MusicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MusicCell_ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:MusicCell_ID]) {
        
    }
    return self;
}

- (void)setMusicItem:(MusicItem *)musicItem {
    _musicItem= musicItem;
    self.textLabel.text = _musicItem.name;
    self.detailTextLabel.text = _musicItem.singer;
    
    if (_musicItem.isPlaying) {
        self.imageView.image = [ImageTool circleImageWithName:_musicItem.singerIcon borderWidth:2.0 borderColor:[UIColor eggshellColor]];
    }
    else{
        self.imageView.image = [ImageTool circleImageWithName:_musicItem.singerIcon borderWidth:2.0 borderColor:[UIColor pinkColor]] ;
    }
}

@end

