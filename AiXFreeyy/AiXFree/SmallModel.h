//
//  SmallModel.h
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallModel : NSObject
@property(nonatomic,copy)NSString *headImageUrl;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *collectNum;//收藏

@property(nonatomic,copy)NSString *starNum;//星级

@property(nonatomic,copy)NSString *loadNum;//下载次数

@property(nonatomic,strong)NSMutableArray *smallData;

-(void)setData:(NSDictionary*)dic;
@end
