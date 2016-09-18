//
//  StartLiveView.h
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/14.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseButtonBlock)();

@protocol StartLiveViewDelegate <NSObject>

// 开始直播
- (void)startLive;

@end

@interface StartLiveView : UIView

@property (nonatomic, copy) CloseButtonBlock block;

@property (nonatomic, assign) id<StartLiveViewDelegate> delegate;

@end
