//
//  LiveModel.h
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreatorModel;
@interface LiveModel : NSObject

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) CreatorModel *creator;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *share_addr;

@property (nonatomic, copy) NSString *stream_addr;

@property (nonatomic, assign) NSUInteger group;

@property (nonatomic, assign) NSUInteger link;

@property (nonatomic, assign) NSUInteger multi;

@property (nonatomic, assign) NSUInteger online_users;

@property (nonatomic, assign) NSUInteger optimal;

@property (nonatomic, assign) NSUInteger rotate;

@property (nonatomic, assign) NSUInteger slot;

@property (nonatomic, assign) NSUInteger version;

@end
