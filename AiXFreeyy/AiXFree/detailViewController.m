//
//  detailViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "detailViewController.h"

#define  kCYDETAIL_URL @"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb"
#define kCYNEAR_URL @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346"
@interface detailViewController ()
@property (nonatomic,strong) detailModel *detailModel;
@property (nonatomic,strong) NSMutableArray *nearData;
@end

@implementation detailViewController
-(void)updateDetailUI
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    
    self.Title.text = self.detailModel.detailAppDescription;
    
    NSInteger index = 0;
    for (NSString *imageName in self.detailModel.detailAppImages) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((5 + 60)* index++, 0, 60, self.scrol1.frame.size.height)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
        
        [self.scrol1 addSubview:imageView];
    }
    
    self.scrol1.contentSize = CGSizeMake((60 + 5) * self.detailModel.detailAppImages.count, self.scrol1.frame.size.height);
    
    self.scrol1.alwaysBounceHorizontal = YES;
}

-(void)requestDetailData
{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@",[NSString stringWithFormat:kCYDETAIL_URL,self.appID]);
    [man GET:[NSString stringWithFormat:kCYDETAIL_URL,self.appID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.detailModel = [[detailModel alloc] initWithDic:dic];
        
        [self updateDetailUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)updateNearUI
{
    NSInteger index = 0;
    for (XFreeModel *appModel in self.nearData) {
        nearButton *button = [[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil][0];
        
        button.frame = CGRectMake(60 * index++, 0, 60, self.scrol2.frame.size.height);
        
        [button.imageView sd_setImageWithURL:[NSURL URLWithString:appModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
        
        button.imageView.layer.cornerRadius = 10.0f;
        button.imageView.clipsToBounds = YES;
        button.titleLabel.text = appModel.title;
        
        [self.scrol2 addSubview:button];
    }
    
    self.scrol2.contentSize = CGSizeMake(60 * self.nearData.count, self.scrol2.frame.size.height);
    
    self.scrol2.alwaysBounceHorizontal = YES;
}

-(void)requsetNearAppData
{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [man GET:kCYNEAR_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *appDict in dic[@"applications"]) {
            XFreeModel *appModel = [[XFreeModel alloc] initWithDic:appDict];
            [self.nearData addObject:appModel];
            
        }
        
        [self updateNearUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"应用详情";
    //数据请求
    self.nearData = [[NSMutableArray alloc] init];
    
    [self requestDetailData];
    [self requsetNearAppData];
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
