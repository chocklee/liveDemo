//
//  StartLiveView.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/14.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "StartLiveView.h"
#import <SDAutoLayout.h>
#import "UIColor+HexString.h"

static CGFloat const closeButtonTopOffset = 24.0f;
static CGFloat const closeButtonRightOffset = 23.0f;
static CGFloat const closeButtonSize = 36.0f;
static CGFloat const titleFieldTopOffset = 174.0f;
static CGFloat const titleFieldWidth = 244.0f;
static CGFloat const titleFieldHeight = 50.0f;
static CGFloat const startLiveButtonTopOffset = 139.0f;
static CGFloat const startLiveButtonLeftOffset = 29.0f;
static CGFloat const startLiveButtonRightOffset = 29.0f;
static CGFloat const startLiveButtonHeight = 50.0f;

@interface StartLiveView ()

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UITextField *titleField;

@property (nonatomic, strong) UIButton *startLiveButton;

@end

@implementation StartLiveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatViews];
        [self installConstraints];
    }
    return self;
}

- (void)creatViews {
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"title_button_close"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeButton];
    
    _titleField = [[UITextField alloc] init];
    _titleField.placeholder = @"给直播写个标题吧";
    [_titleField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _titleField.textColor = [UIColor whiteColor];
    _titleField.font = [UIFont boldSystemFontOfSize:30];
    _titleField.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleField];
    
    _startLiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startLiveButton.backgroundColor = [UIColor hexString:@"00d8c9"];
    [_startLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [_startLiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startLiveButton addTarget:self action:@selector(startLiveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startLiveButton];
}

- (void)installConstraints {
    _closeButton.sd_layout
    .topSpaceToView(self, closeButtonTopOffset)
    .rightSpaceToView(self, closeButtonRightOffset)
    .widthIs(closeButtonSize)
    .heightIs(closeButtonSize);
    
    _titleField.sd_layout
    .topSpaceToView(self, titleFieldTopOffset)
    .centerXEqualToView(self)
    .widthIs(titleFieldWidth)
    .heightIs(titleFieldHeight);
    
    _startLiveButton.sd_layout
    .topSpaceToView(_titleField, startLiveButtonTopOffset)
    .leftSpaceToView(self, startLiveButtonLeftOffset)
    .rightSpaceToView(self, startLiveButtonRightOffset)
    .heightIs(startLiveButtonHeight);
    [_startLiveButton setSd_cornerRadiusFromHeightRatio:@0.5];
}

- (void)closeButtonPressed:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

- (void)startLiveButtonPressed:(UIButton *)sender {
    [self removeFromSuperview];
    if (self.delegate) {
        [self.delegate startLive];
    }
}

@end
