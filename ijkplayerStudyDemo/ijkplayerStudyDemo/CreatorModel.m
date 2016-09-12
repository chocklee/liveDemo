//
//  CreatorModel.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "CreatorModel.h"

@implementation CreatorModel

- (void)dealloc {
    self.ID = nil;
    self.nick = nil;
    self.portrait = nil;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

@end
