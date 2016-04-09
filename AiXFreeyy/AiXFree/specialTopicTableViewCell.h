//
//  specialTopicTableViewCell.h
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "specialTopicModel.h"
#import "SmallTableViewCell.h"
#import "SmallModel.h"
#import "HeadLib.h"
#import "ModelHeader.h"
@interface specialTopicTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) NSInteger starIndex;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITableView *appTableView;
@property (weak, nonatomic) IBOutlet UILabel *recommend;
@property (weak, nonatomic) IBOutlet UIImageView *editer;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,strong) NSArray *smalldata;
-(void)reflushUI:(specialTopicModel*)model;
@end
