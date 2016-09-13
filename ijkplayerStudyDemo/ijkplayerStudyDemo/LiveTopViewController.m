//
//  LiveTopViewController.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/13.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "LiveTopViewController.h"
#import <SDAutoLayout.h>

@interface LiveTopViewController ()

@property (nonatomic, strong) UIButton *chatButton;

@property (nonatomic, strong) UIButton *messageButton;

@property (nonatomic, strong) UIButton *giftButton;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) CAEmitterLayer *heartEmitter;

@end

@implementation LiveTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBottomButtons];
    
    [self setupEmitterAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBottomButtons {
    // 添加聊天按钮
    _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_chatButton setImage:[UIImage imageNamed:@"mg_room_btn_liao_h"] forState:UIControlStateNormal];
    [_chatButton addTarget:self action:@selector(chatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chatButton];
    _chatButton.sd_layout.bottomSpaceToView(self.view, 10).leftSpaceToView(self.view, 10).widthIs(40).heightIs(40);
    
    // 添加分享按钮
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setImage:[UIImage imageNamed:@"mg_room_btn_fenxiang_h"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareButton];
    _shareButton.sd_layout.bottomSpaceToView(self.view, 10).rightSpaceToView(self.view, 60).widthIs(40).heightIs(40);
    
    // 添加礼物按钮
    _giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_giftButton setImage:[UIImage imageNamed:@"mg_room_btn_liwu_h"] forState:UIControlStateNormal];
    [_giftButton addTarget:self action:@selector(giftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_giftButton];
    _giftButton.sd_layout.bottomSpaceToView(self.view, 10).rightSpaceToView(_shareButton, 10).widthIs(40).heightIs(40);
    
    // 添加信息按钮
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setImage:[UIImage imageNamed:@"mg_room_btn_xinxi_h"] forState:UIControlStateNormal];
    [_messageButton addTarget:self action:@selector(messageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_messageButton];
    _messageButton.sd_layout.bottomSpaceToView(self.view, 10).rightSpaceToView(_giftButton, 10).widthIs(40).heightIs(40);
}

- (void)setupEmitterAnimation {
    // 创建发射源
    _heartEmitter = [CAEmitterLayer layer];
    // 粒子发射位置
    _heartEmitter.emitterPosition = CGPointMake(self.view.frame.size.width - 80, self.view.frame.size.height - 60);
    // 发射源的尺寸大小
    _heartEmitter.emitterSize = CGSizeMake(20, 20);
    // 发射模式 
    _heartEmitter.emitterMode = kCAEmitterLayerVolume;
    // 发射源的形状
    _heartEmitter.emitterShape = kCAEmitterLayerPoint;
    // 发射源的渲染模式
    _heartEmitter.renderMode = kCAEmitterLayerUnordered;
    // 创建心形粒子
    CAEmitterCell *heartCell = [CAEmitterCell emitterCell];
    // 粒子的名字
    heartCell.name = @"heart";
    // 粒子的创建速率
    heartCell.birthRate = 3.0;
    // 粒子的存活时间
    heartCell.lifetime = 3.0;
    // 粒子的生存时间容差
    heartCell.lifetimeRange = 0.5;
    // 粒子的速度
    heartCell.velocity = arc4random_uniform(50) + 50.0;
    // 粒子的速度范围
    heartCell.velocityRange = 10.0;
    // 粒子在xy平面的发射角度
    heartCell.emissionLongitude = M_PI + M_PI_2;
    // 发射角度偏移范围
    heartCell.emissionRange = M_PI_4 / 6;
    // 粒子的内容
    heartCell.contents = (id)[UIImage imageNamed:@"room_heart"].CGImage;
    // 设置粒子的颜色
    heartCell.color = [UIColor whiteColor].CGColor;
    heartCell.redRange = 1.5f;
    heartCell.greenRange = 2.2f;
    heartCell.blueRange = 2.2f;
    heartCell.alphaRange = 0.8f;
    // 粒子的缩放大小
    heartCell.scale = 0.5f;
    // 粒子的缩放范围
    heartCell.scaleRange = 0.3f;
    // 粒子边缘的颜色
    _heartEmitter.shadowColor  = [[UIColor whiteColor] CGColor];
    // 添加粒子
    _heartEmitter.emitterCells = @[heartCell];
    // 将粒子layer添加进图层
    [self.view.layer addSublayer:_heartEmitter];
}

#pragma mark - Button Action
- (void)chatButtonPressed:(UIButton *)sender {
    NSLog(@"聊天");
}

- (void)shareButtonPressed:(UIButton *)sender {
    NSLog(@"分享");
}

- (void)giftButtonPressed:(UIButton *)sender {
    NSLog(@"礼物");
}

- (void)messageButtonPressed:(UIButton *)sender {
    NSLog(@"信息");
}

#pragma mark - 懒加载
//- (CAEmitterLayer *)heartEmitter {
//    if (!_heartEmitter) {
//
//        
//    }
//    return _heartEmitter;
//}

@end
