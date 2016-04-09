//
//  YFshareData.m
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "YFshareData.h"

@implementation YFshareData
{
    NSManagedObjectContext *_context;
}
- (id)init
{
    self = [super init];
    if (self) {
        //self.datas = [[NSMutableArray alloc] init];
        NSString *path = [NSString stringWithFormat:@"%@/Documents/app",NSHomeDirectory()];
        NSLog(@"%@",[NSString stringWithFormat:@"%@/Documents/app.db",NSHomeDirectory()]);
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"CollectNum" ofType:@"momd"]]];
        
        NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

        if(![store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil])
        {
            NSLog(@"创建失败");
        }
        else
        {
            
            _context= [[NSManagedObjectContext alloc] init];
            
            _context.persistentStoreCoordinator = store;

            }

        }

   
    return self;
}

+(YFshareData *)sharedInstance
{
    static YFshareData *sharedData = nil;
    
    if(sharedData == nil)
    {
        sharedData = [[YFshareData alloc] init];
    }
    
    return sharedData;
}
-(NSArray*)getCollectCounts
{
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"CollectModel"];
    
    NSArray *appArray = [_context executeFetchRequest:req error:nil];
    
    return appArray;}

-(BOOL)isAppExists:(NSString *)appID
{
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"CollectModel"];
    
    req.predicate = [NSPredicate predicateWithFormat:@"appid = %@",appID];
    
    return [_context countForFetchRequest:req error:nil];
}

-(void)insertAppModel:(detailModel *)detailModel
{
    id obj = [NSEntityDescription insertNewObjectForEntityForName:@"CollectModel" inManagedObjectContext:_context];
    
    [obj setValue:detailModel.headImageUrl forKey:@"image"];
    [obj setValue:detailModel.title forKey:@"title"];
    [obj setValue:detailModel.appID forKey:@"appid"];
    
    [_context save:nil];
}

-(void)removeAppModel:(NSString *)appID
{
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"CollectModel"];
    
    req.predicate = [NSPredicate predicateWithFormat:@"appid = %@",appID];
    
    NSArray *appArray = [_context executeFetchRequest:req error:nil];
    for (NSManagedObject *obj in appArray) {
        [_context deleteObject:obj];
    }
    [_context save:nil];
}



@end
