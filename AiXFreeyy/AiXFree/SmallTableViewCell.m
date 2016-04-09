//
//  SmallTableViewCell.m
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SmallTableViewCell.h"

@implementation SmallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)reflushUI:(SmallModel*)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl]placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    
    self.smallTitle.text= model.title;
    NSLog(@"%888@",model.title);
    self.smallCollcetNum.text = model.collectNum;
    self.samallLoadNum.text = model.loadNum;
    [self.starView setStarCount:[model.starNum floatValue]];
    
}
@end
