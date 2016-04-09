//
//  detailController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "detailController.h"
#import "YFshareData.h"
#define  kCYDETAIL_URL @"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb"
#define kCYNEAR_URL @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346"
@interface detailController ()
@property (nonatomic,strong) detailModel *detailmodel;
@property (nonatomic,strong) NSMutableArray *nearData;



@end

@implementation detailController

//static BOOL collectIsYES;

-(void)updateDetailUI
{
//    if (!collectIsYES) {
//        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
//        //[[YFshareData sharedInstance] change:@"JIAN"];
//    }
//    else
//    {
//        [self.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
//       // [[YFshareData sharedInstance] change:@"ADD"];
//    }
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.detailmodel.headImageUrl] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    self.Title.text = self.detailmodel.title;
    self.originalPrice.text = self.detailmodel.price;
    self.type.text =self.detailmodel.type;
    self.starNum.text =self.detailmodel.starNum;
    self.detailLab.text = self.detailmodel.detailAppDescription;
    NSInteger index = 0;
    for (NSString *imageName in self.detailmodel.detailAppImages) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((10 + 60)* index++, 0, 60, self.scrol1.frame.size.height)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
        
        [self.scrol1 addSubview:imageView];
    }
    
    self.scrol1.contentSize = CGSizeMake((60 + 5) * self.detailmodel.detailAppImages.count, self.scrol1.frame.size.height);
    
    self.scrol1.alwaysBounceHorizontal = YES;
}

-(void)requestDetailData
{
    AFHTTPRequestOperationManager *man = [AFHTTPRequestOperationManager manager];
    
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"%@",[NSString stringWithFormat:kCYDETAIL_URL,self.appID]);
    [man GET:[NSString stringWithFormat:kCYDETAIL_URL,self.appID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.detailmodel = [[detailModel alloc] initWithDict:dic];
        
        [self updateDetailUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)updateNearUI
{
    NSInteger index = 0;
    for (XFreeModel *appModel in self.nearData) {
        nearButton *button = [[NSBundle mainBundle] loadNibNamed:@"nearbtn" owner:nil options:nil][0];
        
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
    if([[YFshareData sharedInstance] isAppExists:self.appID])
    {
        [self.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
    }
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

//收藏，分享，下载
- (IBAction)shareBtnClick:(UIButton *)sender {
    
    
}
//收藏
- (IBAction)collectBtnClick:(UIButton *)sender {
    
    if(![[YFshareData sharedInstance] isAppExists:self.detailmodel.appID])
    {
        //
        [sender setTitle:@"已收藏" forState:UIControlStateNormal];
        [[YFshareData sharedInstance] insertAppModel:self.detailmodel];
    }
    else
    {
        [sender setTitle:@"收藏" forState:UIControlStateNormal];
        [[YFshareData sharedInstance] removeAppModel:self.detailmodel.appID];
    }
    
    
}
- (IBAction)downLoadBtnClick:(UIButton *)sender {
    
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
