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
#import "LiveTopViewController.h"

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height

static NSString * const imageURLString = @"http://img.meelive.cn/";

@interface LiveViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) IJKFFMoviePlayerController * player;

@property (nonatomic, strong) LiveTopViewController *ltVC;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, assign) CGFloat topViewX;

@end

@implementation LiveViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLoadingView];
    
    [self setupPlayer];
    
    [self addNotifications];

    [self setupTopView];
    
    [self setupCloseButton];
    
    [self addPanGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (![_player isPlaying]) {
        // 准备播放
        [_player prepareToPlay];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup view
// 创建等待视图
- (void)setupLoadingView {
    // 设置背景图片
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSURL *bgImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageURLString,_live.creator.portrait]];
    if (_live) {
        [_bgImageView sd_setImageWithURL:bgImageUrl];
    } else {
        _bgImageView.image = [UIImage imageNamed:@"bg_zbfx"];
    }
    [self.view addSubview:_bgImageView];
    
    // 给背景图片添加磨玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _bgImageView.frame;
    [_bgImageView addSubview:effectView];
}

// 创建播放器
- (void)setupPlayer {
    //使用默认配置
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    NSURL * url = [[NSURL alloc] init];
    if (_live) {
        url = [NSURL URLWithString:_live.stream_addr];
    } else {
        url = [NSURL URLWithString:@"http://vafd3cb0e.live.126.net/live/5b3da0f454d247beb26bfa543aeffe14.flv"];
    }

    //初始化播放器，播放在线视频或直播(RTMP)
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options];
    _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _player.view.frame = self.view.bounds;
    //缩放模式
    _player.scalingMode = IJKMPMovieScalingModeAspectFill;
    //开启自动播放
    _player.shouldAutoplay = YES;
    [self.view addSubview:_player.view];
}

// 设置顶部视图
- (void)setupTopView {
    _ltVC = [[LiveTopViewController alloc] init];
    [self addChildViewController:_ltVC];
    [self.view addSubview:_ltVC.view];
    _topViewX = _ltVC.view.frame.origin.x;
}

// 创建按钮
- (void)setupCloseButton {
    // 添加关闭按钮
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    _closeButton.sd_layout.bottomSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).widthIs(40).heightIs(40);
}

// 关闭按钮点击事件
- (void)closeButtonPressed:(UIButton *)sender {
    // 一定要停止播放，否则会造成内存泄漏
    [_player shutdown];
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加拖拽手势
- (void)addPanGestureRecognizer {
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:_panGestureRecognizer];
}

// 拖拽手势响应方法
- (void)handlePan:(UIPanGestureRecognizer *)sender {
    // 返回一个CGpoint,这个Point的内容代表当前鼠标相对于刚开始（按下的位置）的相对坐标。
    CGPoint point = [sender translationInView:sender.view];
    if (sender.state == UIGestureRecognizerStateChanged) {
        if (_ltVC.view.frame.origin.x + point.x > 0) {
            _ltVC.view.transform = CGAffineTransformTranslate(_ltVC.view.transform, point.x, 0);
            [sender setTranslation:CGPointZero inView:sender.view];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_topViewX == 0) {
            if (_ltVC.view.frame.origin.x > 50) {
                [UIView animateWithDuration:0.2 animations:^{
                    _ltVC.view.frame = CGRectMake(SW, 0, SW, SH);
                } completion:^(BOOL finished) {
                    _topViewX = SW;
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    _ltVC.view.frame = CGRectMake(0, 0, SW, SH);
                } completion:^(BOOL finished) {
                    _topViewX = 0;
                }];
            }
        }
        if (_topViewX == SW) {
            if (_ltVC.view.frame.origin.x > SW - 70) {
                [UIView animateWithDuration:0.2 animations:^{
                    _ltVC.view.frame = CGRectMake(SW, 0, SW, SH);
                } completion:^(BOOL finished) {
                    _topViewX = SW;
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    _ltVC.view.frame = CGRectMake(0, 0, SW, SH);
                } completion:^(BOOL finished) {
                    _topViewX = 0;
                }];
            }
        }
    }
}

#pragma mark - notification
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
}

#pragma mark - notification func
- (void)loadStateDidChange:(NSNotification *)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification *)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification *)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification *)notification {
    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

- (void)dealloc {
    [self removeNotification];
}

@end
