//
//  MusicListViewController.m
//  FRMusicPlayer
//
//  Created by 张福润 on 2016/12/23.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicPlayingViewController.h"

#import "MusicCell.h"

#import "MusicItem.h"

#import "MusicTool.h"

@interface MusicListViewController ()
@property (nonatomic, strong) MusicPlayingViewController *playingVc;
@property (nonatomic, assign) int currentIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods
- (MusicPlayingViewController *)playingVc
{
    if (_playingVc == nil) {
        _playingVc = [[MusicPlayingViewController alloc] initWithNibName:@"MusicPlayingViewController" bundle:nil];
        _playingVc.view.bounds = [[UIApplication sharedApplication].delegate window].bounds;
    }
    return _playingVc;
}

- (void)setupNavigation{
    self.navigationItem.title = @"音乐播放器";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MusicTool musics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicCell *cell = [MusicCell musicCellWithTableView:tableView];
    cell.musicItem = [MusicTool musics][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MusicTool setPlayingMusic:[MusicTool musics][indexPath.row]];
    
    MusicItem *preMusic = [MusicTool musics][self.currentIndex];
    preMusic.playing = NO;
    MusicItem *music = [MusicTool musics][indexPath.row];
    music.playing = YES;
    NSArray *indexPaths = @[
                            [NSIndexPath indexPathForItem:self.currentIndex inSection:0],
                            indexPath
                            ];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    
    self.currentIndex = (int)indexPath.row;
    
    [self.playingVc show];
}
@end

