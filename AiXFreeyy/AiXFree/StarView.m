//
//  StarView.m
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "StarView.h"

@implementation StarView

{
    UIImageView *_backImageView;
    
    UIImageView *_foreImageView;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImageView.image = [UIImage imageNamed:@"StarsBackground"];
        
        [self addSubview:_backImageView];
        
        _foreImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _foreImageView.image = [UIImage imageNamed:@"StarsForeground"];
        
        _foreImageView.clipsToBounds = YES;
        
        _foreImageView.contentMode = UIViewContentModeLeft;
        
        [self addSubview:_foreImageView];
    }
    return self;
}

-(void)setStarCount:(CGFloat)value
{
    CGRect oldFrame = _backImageView.frame;
    oldFrame.size.width *= value / 5.0f;
    _foreImageView.frame = oldFrame;
}

@end
