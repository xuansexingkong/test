//
//  baseViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()

@end

@implementation baseViewController
-(UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}
-(void)createUI
{
    self.headView = [[MJRefreshHeaderView alloc] initWithScrollView:self.tableView];
    self.footView = [[MJRefreshFooterView alloc] initWithScrollView:self.tableView];
    
    self.headView.delegate = self;
    self.footView.delegate = self;
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView == self.headView)
    {
        self.starIndex = 0;
        
        self.isDown = YES;

    }
    else if(refreshView == self.footView)
    {
        self.starIndex += 1;
        self.isDown = NO;
    }
    
    [self loadData];
    
    //停止刷新
    [refreshView performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0f];
}
-(void)loadData
{

}
-(void)creatSearchBar
{
    _search = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    // 是否在搜索的时候使底色变暗
    _search.dimsBackgroundDuringPresentation = NO;
    
    //设置搜索控制器的代理对象
    _search.delegate = self;
    _search.searchResultsUpdater = self;
    
    //UISearchBar   用于管理搜索框属性的类
    
    //根据视图的大小匹配搜索框的大小
    [_search.searchBar sizeToFit];
    
    //提示框的文字
    _search.searchBar.placeholder = @"60万款应用搜索看";
    
    self.tableView.tableHeaderView = _search.searchBar;
    _resultArray = [[NSMutableArray alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.data = [[NSMutableArray alloc]init];
    [self.view addSubview:self.tableView];
    [self creatSearchBar];
    self.edgesForExtendedLayout = 0;
     [self createUI];
    // Do any additional setup after loading the view.
}
-(void)getSearchData
{

}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    _isSearching = YES;  //打开开关进行搜索
    NSLog(@"文字有变动");
    
    //点击搜索框时，每次都先清除上一次搜索到的数据
    [ self.resultArray removeAllObjects];
    //循环从列表中获取每一行的列表数据
    [self getSearchData];
    [self.tableView reloadData];   //数据存储后重新加载协议的方法
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)didDismissSearchController:(UISearchController *)searchController
{
    _isSearching = NO;   //取消搜索后关闭开关
    
    [self.tableView reloadData];  //数据存储后重新加载协议的方法
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10.0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
    
}
-(void)setModelAppID:(NSIndexPath*)indexPath
{
//    CYAppModel *appModel = self.data[indexPath.row];
//    detailViewController *detailVC = [[NSClassFromString(@"detailViewController") alloc] init];
//    
//    [detailVC setValue:appModel.appID forKey:@"appID"];
//    
//    [self.navigationController pushViewController:detailVC animated:YES];

}
//指定行编辑
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![self isKindOfClass:[NSClassFromString(@"SpecialTopicViewController") class]])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        [self setModelAppID:indexPath];
    }
}
//设置
-(void)setting
{
    settingsViewController *setcont = [[settingsViewController alloc]init];
    [self.navigationController pushViewController:setcont animated:YES];
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
