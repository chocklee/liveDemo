//
//  LiveViewController.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "LiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LiveModel.h"
#import "CreatorModel.h"
#import <UIImageView+WebCache.h>
#import <SDAutoLayout.h>

static NSString * const imageURLString = @"http://img.meelive.cn/";

@interface LiveViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) IJKFFMoviePlayerController * player;

@end

@implementation LiveViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景图片
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSURL *bgImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageURLString,_live.creator.portrait]];
    [_bgImageView sd_setImageWithURL:bgImageUrl];
    [self.view addSubview:_bgImageView];
    
    // 给背景图片添加磨玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _bgImageView.frame;
    [_bgImageView addSubview:effectView];
    
    //使用默认配置
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    NSURL * url = [NSURL URLWithString:_live.stream_addr];
    //初始化播放器，播放在线视频或直播(RTMP)
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options];
    _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _player.view.frame = self.view.bounds;
    //缩放模式
    _player.scalingMode = IJKMPMovieScalingModeAspectFill;
    //开启自动播放
    _player.shouldAutoplay = YES;
    [self.view addSubview:_player.view];
    
    // 添加关闭按钮
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    _closeButton.sd_layout.bottomSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).widthIs(40).heightIs(40);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    // 准备播放
    [self.player prepareToPlay];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 一定要停止播放，否则会造成内存泄漏
    [self.player shutdown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
