//
//  baseViewController.h
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResltTableViewController.h"
#import "HeadLib.h"
#import "detailController.h"
#import "settingsViewController.h"
@interface baseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISearchController *search;
@property (nonatomic,strong) NSMutableArray *resultArray;  //进行搜索后显示的数据
@property (nonatomic) BOOL isSearching;     //加一个开口，用于判断是否进行了搜索
@property (nonatomic,strong) NSMutableArray *data;
//上/下拉
@property (nonatomic,strong) MJRefreshHeaderView *headView;
@property (nonatomic,strong) MJRefreshFooterView *footView;
@property(nonatomic)NSInteger starIndex;
@property (nonatomic) BOOL isDown;

@end
