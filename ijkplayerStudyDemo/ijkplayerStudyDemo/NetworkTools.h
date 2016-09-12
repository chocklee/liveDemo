//
//  NetworkTools.h
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^ErrorBlock)(NSError *error);

typedef void(^LiveListBlock)(NSArray *listArray);

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)shareNetwordTools;

- (void)getLiveListWithUId:(NSNumber *)uid andInterest:(NSNumber *)interest andLocation:(NSNumber *)location withLiveListBlock:(LiveListBlock)liveListBlock withErrorBlock:(ErrorBlock)errorBlock;

@end
