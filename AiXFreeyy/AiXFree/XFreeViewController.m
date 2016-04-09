//
//  XFreeViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "XFreeViewController.h"
#import "XFreeModel.h"
#import "XFreeTableViewCell.h"
#define XFreeurl @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=%ld"
@interface XFreeViewController ()

@end

@implementation XFreeViewController

-(void)loadData
{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    [man GET:[NSString stringWithFormat:XFreeurl,self.starIndex+1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(self.isDown == YES)
        {
            [self.data removeAllObjects];
            self.isDown = NO;
        }
        NSDictionary *movieDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        for (NSDictionary *app in movieDict[@"applications"]) {
            XFreeModel *appmodel = [[XFreeModel alloc] initWithDic:app];
            [self.data addObject:appmodel];
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

    XFreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XFreeCell"];
    if(self.isSearching)  //是否进行搜索的开关控制
    {
        XFreeModel*Model = self.resultArray[indexPath.row];
        [cell reflushUI:Model];
    }else{
        XFreeModel*model = self.data[indexPath.row];
        [cell reflushUI:model];
    }

   
    return cell;
}
//剩余时间
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
        
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",com.hour,com.minute,com.second];
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XFreeTableViewCell" bundle:nil] forCellReuseIdentifier:@"XFreeCell"];
   
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
//详情
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
