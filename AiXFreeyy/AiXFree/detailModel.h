//
//  detailModel.h
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFreeModel.h"
@interface detailModel : XFreeModel
@property (nonatomic,strong) NSString *detailAppDescription;

@property (nonatomic,strong) NSMutableArray *detailAppImages;
-(id)initWithDict:(NSDictionary *)dict;
@end
