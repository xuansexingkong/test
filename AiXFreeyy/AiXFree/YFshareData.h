//
//  YFshareData.h
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "detailModel.h"
@interface YFshareData : NSObject
//@property (nonatomic,strong) NSMutableArray *datas;
//@property (nonatomic,assign) NSInteger counts;

+(YFshareData *)sharedInstance;

-(NSArray*)getCollectCounts;

-(BOOL)isAppExists:(NSString *)appID;

-(void)insertAppModel:(detailModel *)detailModel;

-(void)removeAppModel:(NSString *)appID;

@end
