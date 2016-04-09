//
//  AiXFreeViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AiXFreeViewController.h"
#import "settingsViewController.h"
@interface AiXFreeViewController ()

@end

@implementation AiXFreeViewController
-(UIImage *)setImageRenderMode:(UIImage *)image
{
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)creatViewC
{
    
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    NSArray *tabBarInfos = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TabBar" ofType:@"plist"]];
    
    for (NSDictionary *tabBarInfo in tabBarInfos) {
        UIViewController *vc = [[NSClassFromString(tabBarInfo[@"className"]) alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:@selector(classify)];
        vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:vc action:@selector(setting)];
        vc.navigationItem.title = tabBarInfo[@"title"];
        //设置导航titlt
        [vc.navigationController.navigationBar setTitleTextAttributes:
         
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
           
           NSForegroundColorAttributeName:[UIColor blueColor]}];
        
        nav.tabBarItem.title = tabBarInfo[@"title"];
        nav.tabBarItem.image = [self setImageRenderMode:[UIImage imageNamed:tabBarInfo[@"image"]]];
        nav.tabBarItem.selectedImage = [self setImageRenderMode:[UIImage imageNamed:tabBarInfo[@"selectimage"]]];
        
        [vcs addObject:nav];
    }
    
    self.viewControllers = vcs;
    
    
    
}
-(void)classify
{
    NSLog(@"分类");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewC];
    // Do any additional setup after loading the view.
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
