//
//  CollectViewController.m
//  AiXFree
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CollectViewController.h"
#import "YFCollectionViewCell.h"
@interface CollectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic) BOOL isEdit;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Do any additional setup after loading the view.
}
-(UICollectionView *)collectionView
{
    if(_collectionView == nil)
    {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(100, 100);
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"YFCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    
    return _collectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    id appObj = self.data[indexPath.item];
    cell.closeBtn.hidden = !self.isEdit;
    [cell.imageVIew sd_setImageWithURL:[NSURL URLWithString:[appObj valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    cell.titleLabel.text = [appObj valueForKey:@"title"];
    
    cell.closeBtn.tag = indexPath.item;
    
    [cell.closeBtn addTarget:self action:@selector(removeAppModel:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)removeAppModel:(UIButton *)btn
{
    id appObj = self.data[btn.tag];
    
    //删除数据源
    [self.data removeObjectAtIndex:btn.tag];
    [self.collectionView reloadData];
    
    //数据库
    [[YFshareData sharedInstance] removeAppModel:[appObj valueForKey:@"appid"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.isEdit = !self.isEdit;
    [self.collectionView reloadData];
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
