//
//  specialTopicModel.m
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "specialTopicModel.h"

@implementation specialTopicModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.headImageUrl =dic[@"img"];
        self.tabviewArr=dic[@"applications"];

        self.recommend = dic[@"desc"];
    }
    return self;
}

@end
