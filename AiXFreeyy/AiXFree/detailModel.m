//
//  detailModel.m
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "detailModel.h"

@implementation detailModel
-(id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDic:dict];
    if (self) {
        //图片
        self.detailAppDescription = dict[@"description"];
        //NSLog(@"222%@",dict[@"description"]);
        self.detailAppImages = [[NSMutableArray alloc] init];
        
        for (NSDictionary *imageDict in dict[@"photos"]) {
            [self.detailAppImages addObject:imageDict[@"smallUrl"]];
        }
    }
    return self;
}

@end
