//
//  DownPriceTableViewCell.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DownPriceTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DownPriceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)reflushUI:(DownPriceModel*)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl]placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    self.headImage.layer.cornerRadius = 15;
    self.headImage.clipsToBounds = YES;
    self.title.text= model.title;
    self.currentPrice.text=model.currentPrice ;
    [self.level setStarCount:[model.starNum floatValue]];

    self.sharenum.text= model.shareNum;
    self.collectNum.text= model.collectNum;
    self.loadNum.text= model.loadNum;
    self.money.text= model.price;
    self.type.text= model.type;
}

@end
