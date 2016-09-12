//
//  CreatorModel.h
//  ijkplayerStudyDemo
//
//  Created by chocklee on 16/9/9.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatorModel : NSObject

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, assign) NSUInteger level;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *portrait;

@end
