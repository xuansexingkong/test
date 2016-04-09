//
//  specialTopicModel.h
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmallModel.h"
@interface specialTopicModel : NSObject
@property(nonatomic,copy)NSString *headImageUrl;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *recommend;//推荐

@property(nonatomic,copy)NSArray *tabviewArr;//tabview



- (instancetype)initWithDic:(NSDictionary *)dic;
@end
