//
//  LiveView.h
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/18.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LiveViewDelegate <NSObject>

// 关闭直播
- (void)closeLive;

@end

@class LFLiveSession;
@interface LiveView : UIView

@property (nonatomic, assign) id<LiveViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andLiveSession:(LFLiveSession *)session;

@end
