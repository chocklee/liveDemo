//
//  NetworkTools.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "NetworkTools.h"
#import <YYModel.h>
#import "LiveModel.h"

static NSString * const baseURLString = @"http://218.11.0.112/api/";
static NSString * const liveURLString = @"live/aggregation?";

@implementation NetworkTools

+ (instancetype)shareNetwordTools {
    static NetworkTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:baseURLString];
        tools = [[NetworkTools alloc] initWithBaseURL:baseURL];
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        tools.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //设置缓存
        NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
        [NSURLCache setSharedURLCache:URLCache];
    });
    return tools;
}

- (void)getLiveListWithUId:(NSNumber *)uid andInterest:(NSNumber *)interest andLocation:(NSNumber *)location withLiveListBlock:(LiveListBlock)liveListBlock withErrorBlock:(ErrorBlock)errorBlock {
    NSDictionary *parmeters = @{@"uid":uid, @"interest":interest, @"location":location};
    [self GET:liveURLString parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSMutableArray *livesArray = [NSMutableArray array];
        NSArray *lives = responseObject[@"lives"];
        for (NSDictionary *liveDic in lives) {
            LiveModel *live = [LiveModel yy_modelWithDictionary:liveDic];
            [livesArray addObject:live];
        }
        liveListBlock(livesArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
