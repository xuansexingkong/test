//
//  SpecialTopicViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SpecialTopicViewController.h"
#define kCYSUBJECT_URL @"http://10.0.8.10/app/qfts/iappfree/api/topic.php?page=%ld&number=20"

@interface SpecialTopicViewController ()
{
    specialTopicTableViewCell *_spcell;
}
@end

@implementation SpecialTopicViewController
-(void)loadData
{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    [man GET:[NSString stringWithFormat:kCYSUBJECT_URL,self.starIndex+1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(self.isDown == YES)
        {
            [self.data removeAllObjects];
            self.isDown = NO;
        }

        NSArray *movieDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        for (NSDictionary *app in movieDict) {
            specialTopicModel *appmodel = [[specialTopicModel alloc] initWithDic:app];
            
//           SmallModel *smallModel = [[SmallModel alloc]initWithDic:app[@"applications"]];
//            [_spcell.data addObject:smallModel];
            [self.data addObject:appmodel];
        }
        
        //刷新数据
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        specialTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spcialCell"];
        specialTopicModel*model = self.data[indexPath.row];
        [cell reflushUI:model];
        return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _spcell = [[specialTopicTableViewCell alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"specialTopicTableViewCell" bundle:nil] forCellReuseIdentifier:@"spcialCell"];
    [self loadData];
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
