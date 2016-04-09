//
//  XFreeTableViewCell.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "XFreeTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation XFreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)getTime:(NSString *)timeStr
{
    //获取当前时间
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //S 毫秒
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    
    NSDate *endDate = [dateFormat dateFromString:timeStr];
    
    //日历
    NSCalendar *cale = [NSCalendar currentCalendar];
    
    if(date && endDate)
    {
        //过滤
        NSCalendarUnit mask = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        //fromDate toDate
        
        NSDateComponents *com = [cale components:mask fromDate:date toDate:endDate options:0];
        NSLog(@"%@",[NSString stringWithFormat:@"%02ld:%02ld:%02ld",com.hour,com.minute,com.second]); 
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",com.hour,com.minute,com.second];
        
    }
    return nil;
}

-(void)reflushUI:(XFreeModel*)model
{
    [self.XfreecellImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl]placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    self.XfreecellImage.layer.cornerRadius = 15;
    self.XfreecellImage.clipsToBounds = YES;
    self.XfreecellTitle.text= model.title;
    self.XfreecellSubTitle.text=[self getTime:model.time]; ;
    
    [self.level setStarCount:[model.starNum floatValue]];
    
    self.shareNum.text= model.shareNum;
    self.collectNum.text= model.collectNum;
    
    self.loadNum.text= model.loadNum;
    self.money.text= model.price;
    self.type.text= model.type;
}
@end
