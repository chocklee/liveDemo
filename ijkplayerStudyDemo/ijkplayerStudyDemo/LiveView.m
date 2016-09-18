//
//  LiveView.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/18.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "LiveView.h"
#import <LFLiveSession.h>
#import <SDAutoLayout.h>

@interface LiveView ()

@property (nonatomic, strong) LFLiveSession *session;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *switchCamareButton;

@property (nonatomic, strong) UIButton *beautyFaceButton;

@property (nonatomic, strong) UIButton *flashLampButton;

@property (nonatomic, assign) BOOL isLightOn;

@end

@implementation LiveView

- (instancetype)initWithFrame:(CGRect)frame andLiveSession:(LFLiveSession *)session {
    if (self = [super initWithFrame:frame]) {
        self.session = session;
        self.isLightOn = NO;
        [self creatViews];
        [self installConstraints];
    }
    return self;
}

- (void)creatViews {
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeButton];
    
    _switchCamareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_switchCamareButton setImage:[UIImage imageNamed:@"mg_room_icon_camera"] forState:UIControlStateNormal];
    [_switchCamareButton addTarget:self action:@selector(switchCamareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_switchCamareButton];
    
    _flashLampButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_flashLampButton setImage:[UIImage imageNamed:@"mg_room_icon_set"] forState:UIControlStateNormal];
    [_flashLampButton addTarget:self action:@selector(flashLampButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_flashLampButton];
    
    _beautyFaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_beautyFaceButton setImage:[UIImage imageNamed:@"camra_beauty"] forState:UIControlStateNormal];
    [_beautyFaceButton setImage:[UIImage imageNamed:@"camra_beauty_close"] forState:UIControlStateSelected];
    [_beautyFaceButton addTarget:self action:@selector(beautyFaceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_beautyFaceButton];
}

- (void)installConstraints {
    _closeButton.sd_layout
    .bottomSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .widthIs(40)
    .heightIs(40);
    
    _switchCamareButton.sd_layout
    .bottomSpaceToView(self, 10)
    .rightSpaceToView(_closeButton, 10)
    .widthIs(40)
    .heightIs(40);
    
    _flashLampButton.sd_layout
    .bottomSpaceToView(self, 10)
    .rightSpaceToView(_switchCamareButton, 10)
    .widthIs(40)
    .heightIs(40);
    
    _beautyFaceButton.sd_layout
    .bottomSpaceToView(self, 10)
    .rightSpaceToView(_flashLampButton, 10)
    .widthIs(40)
    .heightIs(40);
}

- (void)closeButtonPressed:(UIButton *)sender {
    if (self.delegate) {
        [self.delegate closeLive];
    }
}

// 切换前后摄像头
- (void)switchCamareButtonPressed:(UIButton *)sender {
    AVCaptureDevicePosition devicePosition = _session.captureDevicePosition;
    _session.captureDevicePosition = (devicePosition == AVCaptureDevicePositionFront) ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
}

// 开关闪关灯
- (void)flashLampButtonPressed:(UIButton *)sender {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && _session.captureDevicePosition == AVCaptureDevicePositionBack) {
        [device lockForConfiguration:nil];
        if (self.isLightOn) {
            [device setTorchMode:AVCaptureTorchModeOff];
            self.isLightOn = NO;
        } else {
            [device setTorchMode:AVCaptureTorchModeOn];
            self.isLightOn = YES;
        }
        [device unlockForConfiguration];
    } else {
        NSLog(@"前置摄像头闪光灯不可用");
    }
}

// 开启关闭美颜效果
- (void)beautyFaceButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    _session.beautyFace = !_session.beautyFace;
}

@end
