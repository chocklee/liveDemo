//
//  UIView+RoundedCorner.m
//  Test
//
//  Created by 李长浩 on 16/7/14.
//  Copyright © 2016年 chocklee. All rights reserved.
//

#import "UIView+RoundedCorner.h"

@implementation UIView (RoundedCorner)

- (void)setRoundedCornerOnTop {
    [self setRoundedCornerOnTopWithScale:0.5];
}

- (void)setRoundedCornerOnBottom {
    [self setRoundedCornerOnBottomWithScale:0.5];
}

- (void)setRoundedCorner {
    [self setRoundedCornerWithScale:0.5];
}

- (void)removeRoundedCorner {
    self.layer.mask = nil;
}

- (void)setRoundedCornerWithScale:(CGFloat)scale {
    if (scale > 0.5) {
        scale = 0.5;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.height * scale];
    [self setShapeLayer:maskPath];
}

- (void)setRoundedCornerOnTopWithScale:(CGFloat)scale {
    if (scale > 0.5) {
        scale = 0.5;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.frame.size.height * scale, self.frame.size.height * scale)];
    [self setShapeLayer:maskPath];
}

- (void)setRoundedCornerOnBottomWithScale:(CGFloat)scale {
    if (scale > 0.5) {
        scale = 0.5;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.frame.size.height * scale, self.frame.size.height * scale)];
    [self setShapeLayer:maskPath];
}

- (void)setShapeLayer:(UIBezierPath *)maskPath {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
