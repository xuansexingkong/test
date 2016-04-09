//
//  HotTableViewCell.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)reflushUI:(HotAppModel*)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl]placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    self.headImage.layer.cornerRadius = 15;
    self.headImage.clipsToBounds = YES;
    self.title.text= model.title;
    self.mark.text=model.mark;
   // self.starView.image =[UIImage imageNamed:@"StarsForeground"];//暂时是本地图片
    [self.starView setStarCount:[model.starNum floatValue]];
    self.shareNum.text= model.shareNum;
    self.collectNum.text= model.collectNum;
    self.loadNum.text= model.loadNum;
    self.type.text= model.type;
    self.price.text = model.Price;
}

@end
