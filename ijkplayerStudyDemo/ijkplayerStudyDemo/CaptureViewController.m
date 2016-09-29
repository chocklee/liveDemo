//
//  CaptureViewController.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "CaptureViewController.h"
#import "StartLiveView.h"
#import <LFLiveKit.h>
#import "LiveView.h"

@interface CaptureViewController () <StartLiveViewDelegate, LFLiveSessionDelegate, LiveViewDelegate>

@property (nonatomic, strong) StartLiveView *startLiveView;
@property (nonatomic, strong) LiveView *liveView;

@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, strong) UIView *livePreView;

@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.livePreView];
    self.session.running = YES;
    
    [self addStartLiveView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加开始直播视图
- (void)addStartLiveView {
    _startLiveView = [[StartLiveView alloc] initWithFrame:self.view.bounds];
    __weak typeof(self) weakSelf = self;
    _startLiveView.block = ^() {
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    _startLiveView.delegate = self;
    [self.view addSubview:_startLiveView];
}

#pragma mark - 懒加载
- (LFLiveSession *)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.preView = _livePreView;
        _session.delegate = self;
    }
    return _session;
}

- (UIView *)livePreView {
    if (!_livePreView) {
        _livePreView = [[UIView alloc] initWithFrame:self.view.bounds];
        _livePreView.backgroundColor = [UIColor clearColor];
        _livePreView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _livePreView;
}

#pragma mark - LFLiveSessionDelegate
// 直播状态改变回调
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
    switch (state) {
        /// 准备中
        case LFLiveReady:
            NSLog(@"准备中");
            break;
        /// 连接中
        case LFLivePending:
            NSLog(@"连接中");
            break;
        /// 已连接
        case LFLiveStart:
            NSLog(@"已连接");
            break;
        /// 已断开
        case LFLiveStop:
            NSLog(@"已断开");
            break;
        /// 连接出错
        case LFLiveError:
            NSLog(@"连接出错");
            break;
        default:
            break;
    }
}

// 直播调试信息回调
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo {

}

// socket错误代码回调
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode {

}

#pragma mark - StartLiveViewDelegate
- (void)startLive {
    LFLiveStreamInfo *stream = [[LFLiveStreamInfo alloc] init];
    stream.url = @"rtmp://pafd3cb0e.live.126.net/live/5b3da0f454d247beb26bfa543aeffe14?wsSecret=4f1836e75687a154a2a7e2426ab468df&wsTime=1474184854";
    [_session startLive:stream];
    
    // 添加直播视图
    _liveView = [[LiveView alloc] initWithFrame:self.view.bounds andLiveSession:_session];
    _liveView.delegate = self;
    [self.view addSubview:_liveView];
}

#pragma mark - LiveViewDelegate
- (void)closeLive {
    [_session stopLive];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
