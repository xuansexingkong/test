//
//  TrendViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TrendViewController.h"
#define Hoturl @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%ld&number=20"
#define HotSearchurl @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=1&number=20&search=愤怒的小鸟"
@interface TrendViewController ()

@end

@implementation TrendViewController
-(void)loadData
{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    [man GET:[NSString stringWithFormat:Hoturl,self.starIndex+1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(self.isDown == YES)
        {
            [self.data removeAllObjects];
            self.isDown = NO;
        }
        NSDictionary *movieDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *app in movieDict[@"applications"]) {
            HotAppModel *appmodel = [[HotAppModel alloc] initWithDic:app];
            [self.data addObject:appmodel];
            NSLog(@"%@",self.data);
        }
        
        //刷新数据
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isSearching)
    {
        return self.resultArray.count;   //搜索模式就返回搜索出来的行数
    }
    
    return self.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotCell"];
    if(self.isSearching)  //是否进行搜索的开关控制
    {
        HotAppModel*Model = self.resultArray[indexPath.row];
        [cell reflushUI:Model];
    }else{
        HotAppModel*model = self.data[indexPath.row];
        [cell reflushUI:model];
    }
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotCell"];
    [self loadData];
    // Do any additional setup after loading the view.
}
//重写getSearchData
-(void)getSearchData
{
    for (XFreeModel*model in self.data) {
        
        //取出每一行数据后与搜索到的数据作匹配，如果string中包含搜索的数据则添加到_resultArray,返回值为一个范围
        NSRange range = [model.title rangeOfString:self.search.searchBar.text];
        NSLog(@"%@",self.search.searchBar.text);
        
        if(range.location != NSNotFound)
        {
            //存储匹配上的数据
            [self.resultArray addObject:model];
        }
    }
    
}
-(void)setModelAppID:(NSIndexPath*)indexPath
{
    XFreeModel *appModel = self.data[indexPath.row];
    detailController *detailVC = [[NSClassFromString(@"detailController") alloc] init];
    
    [detailVC setValue:appModel.appID forKey:@"appID"];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
