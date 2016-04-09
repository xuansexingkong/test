//
//  HotAppModel.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HotAppModel.h"

@implementation HotAppModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"name"];
        self.headImageUrl = dic[@"iconUrl"];
        self.shareNum = dic[@"shares"];
        self.collectNum=dic[@"favorites"];
        self.starNum=dic[@"starCurrent"];
        self.loadNum=dic[@"downloads"];
        self.mark=dic[@"starCurrent"];
        self.type=dic[@"categoryName"];
        self.Price = dic[@"lastPrice"];
        self.appID = dic[@"applicationId"];
    }
    return self;
}

@end
