//
//  settingsViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "settingsViewController.h"
#import "YFshareData.h"
@interface settingsViewController ()
@property (nonatomic,strong) NSMutableArray *appArrays;
@end

@implementation settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.appArrays = [NSMutableArray arrayWithArray:[[YFshareData sharedInstance] getCollectCounts]];
    // Do any additional setup after loading the view from its nib.
}

//收藏回到设置界面，写在viewWillAppear才会立刻刷新
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectNum.text = [NSString stringWithFormat:@"%ld",self.appArrays.count];
}
- (IBAction)collectClick:(UIButton *)sender {
    
     CollectViewController*storeVC = [[CollectViewController alloc] init];
    
    storeVC.data = self.appArrays;
    
    [self.navigationController pushViewController:storeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
