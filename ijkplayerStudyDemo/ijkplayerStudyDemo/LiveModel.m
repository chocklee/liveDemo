//
//  LiveModel.m
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "LiveModel.h"
#import "CreatorModel.h"
#import <YYModel.h>

@implementation LiveModel

- (void)dealloc {
    self.city = nil;
    self.creator = nil;
    self.ID = nil;
    self.name = nil;
    self.share_addr = nil;
    self.stream_addr = nil;
}

/**
 *  通过实现 协议中的 modelCustomPropertyMapper，可以将 Model 属性的名字对应到 JSON/NSDictionary 相应的字段
 *
 *  @return
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

/**
 *  通过实现 协议中的 modelContainerPropertyGenericClass，返回 Model 属性容器中需要存放的对象类型，YYModel 会自动进行处理。对象类型可以是 Class 或者 Class name
 *
 *  @return
 */
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"creator":CreatorModel.class};
}

@end
