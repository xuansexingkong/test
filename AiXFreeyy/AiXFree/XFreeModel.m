//
//  XFreeModel.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "XFreeModel.h"
@implementation XFreeModel

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
        self.price=dic[@"lastPrice"];
        self.type=dic[@"categoryName"];
        self.time=dic[@"expireDatetime"];
        self.appID = dic[@"applicationId"];
        
    }
    return self;
}
@end
