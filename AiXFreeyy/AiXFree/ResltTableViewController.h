//
//  ResltTableViewController.h
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResltTableViewController : UITableViewController
<UISearchResultsUpdating>

@property (nonatomic,strong) NSArray *data;

@end
