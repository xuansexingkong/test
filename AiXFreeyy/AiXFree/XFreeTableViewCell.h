//
//  XFreeTableViewCell.h
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFreeModel.h"
#import "StarView.h"
@interface XFreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *XfreecellImage;
@property (weak, nonatomic) IBOutlet UILabel *XfreecellTitle;
@property (weak, nonatomic) IBOutlet UILabel *XfreecellSubTitle;
@property (weak, nonatomic) IBOutlet StarView *level;

@property (weak, nonatomic) IBOutlet UILabel *shareNum;
@property (weak, nonatomic) IBOutlet UILabel *collectNum;
@property (weak, nonatomic) IBOutlet UILabel *loadNum;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *type;
-(void)reflushUI:(XFreeModel*)model;
@end
