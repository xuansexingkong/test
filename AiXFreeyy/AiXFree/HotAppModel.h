//
//  HotAppModel.h
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotAppModel : NSObject
@property(nonatomic,copy)NSString *headImageUrl;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *shareNum;//分享

@property(nonatomic,copy)NSString *collectNum;//收藏

@property(nonatomic,copy)NSString *starNum;//星级

@property(nonatomic,copy)NSString *loadNum;//下载次数

@property(nonatomic,copy)NSString *type;//类型

@property(nonatomic,copy)NSString *mark;//评分

@property(nonatomic,copy)NSString *Price;//价格

@property(nonatomic,copy)NSString *appID;//id
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
