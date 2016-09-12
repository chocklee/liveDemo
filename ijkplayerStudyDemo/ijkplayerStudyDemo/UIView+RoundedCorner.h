//
//  UIView+RoundedCorner.h
//  Test
//
//  Created by 李长浩 on 16/7/14.
//  Copyright © 2016年 chocklee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundedCorner)

// 设置顶部圆角
- (void)setRoundedCornerOnTop;

// 设置底部圆角
- (void)setRoundedCornerOnBottom;

// 设置圆角
- (void)setRoundedCorner;

// 取消圆角
- (void)removeRoundedCorner;

// 自定义圆角大小 scale范围：0 ~ 0.5
- (void)setRoundedCornerWithScale:(CGFloat)scale;

// 自定义顶部圆角大小 scale范围：0 ~ 0.5
- (void)setRoundedCornerOnTopWithScale:(CGFloat)scale;

// 自定义底部圆角大小 scale范围：0 ~ 0.5
- (void)setRoundedCornerOnBottomWithScale:(CGFloat)scale;

@end
