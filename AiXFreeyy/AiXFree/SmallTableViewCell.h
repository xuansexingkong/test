//
//  SmallTableViewCell.h
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "SmallModel.h"
#import "HeadLib.h"
@interface SmallTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *smallTitle;
@property (weak, nonatomic) IBOutlet UILabel *smallCollcetNum;
@property (weak, nonatomic) IBOutlet UILabel *samallLoadNum;
@property (weak, nonatomic) IBOutlet StarView *starView;
-(void)reflushUI:(SmallModel*)model;
@end
