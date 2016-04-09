//
//  specialTopicTableViewCell.m
//  AiXFree
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "specialTopicTableViewCell.h"
#import "UIImageView+WebCache.h"
#define kCYSUBJECT_URL @"http://10.0.8.10/app/qfts/iappfree/api/topic.php?page=%ld&number=20"

@implementation specialTopicTableViewCell
//-(void)loadData
//{
//    
//    
//    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
//    man.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [man GET:[NSString stringWithFormat:kCYSUBJECT_URL,self.starIndex+1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSArray *movieDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        for (NSDictionary *app in movieDict) {
//            NSArray *temppArr =app[@"applications"];
//            NSInteger len =temppArr.count;
//
//            tempModel *temp = [[tempModel alloc]init];
//           for (NSInteger i =0; i< len; i++) {
//                SmallModel *appmodel = [[SmallModel alloc] init];
//               [appmodel setData:app[@"applications"][i]];
//          //     [self.smalldata addObject:appmodel];
//               [temp.atempArr addObject:appmodel];
//           }
//
//            [self.data addObject:temp];
//        }
//        // NSLog(@"777%@",self.smalldata);
//        //刷新数据
//        [self.appTableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//
//}
-(void)loadSmallData:(NSArray*)arr
{
    [self.data removeAllObjects];
    // tempModel *temp = [[tempModel alloc]init];
        for (NSInteger i =0; i< arr.count; i++) {
            SmallModel *appmodel = [[SmallModel alloc] init];
            appmodel.title = arr[i][@"name"];
            //NSLog(@"11title=%@",self.title);
            appmodel.headImageUrl = arr[i][@"iconUrl"];
            appmodel.collectNum=arr[i][@"ratingOverall"];
            //  NSLog(@"121title=%@",self.collectNum);
            appmodel.loadNum =arr[i][@"downloads"];
            appmodel.starNum =arr[i][@"starOverall"];
           // [temp.atempArr addObject:appmodel];
             [self.data addObject:appmodel];
        }
    [self.appTableView reloadData];
}
- (void)awakeFromNib {
    // Initialization code
    self.appTableView.contentSize = CGSizeMake(200, 120);
    self.appTableView.alwaysBounceHorizontal = YES;
    self.smalldata = [[NSMutableArray alloc]init];
    self.data = [[NSMutableArray alloc]init];
    [self.appTableView registerNib:[UINib nibWithNibName:@"SmallTableViewCell" bundle:nil] forCellReuseIdentifier:@"smallCell"];
    self.appTableView.delegate =self;
    self.appTableView.dataSource =self;
    [self loadSmallData:self.smalldata];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallCell"];
    cell.backgroundColor  = [UIColor clearColor];
    //tempModel *temodel = self.data[indexPath.row];
    SmallModel*model = self.data[indexPath.row];
    [cell reflushUI:model];    
    return cell;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)reflushUI:(specialTopicModel*)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl]placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];

    self.title.text= model.title;
    self.recommend.numberOfLines = 0;
    self.recommend.text = model.recommend;
    self.smalldata = model.tabviewArr;
    [self loadSmallData:self.smalldata];
    
}

@end
