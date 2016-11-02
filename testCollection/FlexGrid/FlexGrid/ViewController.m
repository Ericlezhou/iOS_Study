//
//  ViewController.m
//  FlexGrid
//
//  Created by Eric on 16/10/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    UICollectionViewFlowLayout *_collectionFlowLayout;
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) NSArray *dataModel;

@end

@implementation ViewController

#pragma mark - setter && getter
-(NSArray *)dataModel{
    if (!_dataModel) {
        _dataModel = @[@"1", @"2", @"3", @"4", @"1", @"2", @"3", @"4", @"1", @"2", @"3", @"4", @"1", @"2", @"3", @"4", @"我从来不骗人", @"我是你的最爱", @"我的心里只有你，你信我就信", @"无辜脸", @"你说话可以不张嘴巴吗？", @"1", @"2", @"6666"];
    }
    return _dataModel;
}
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionFlowLayout.minimumInteritemSpacing = 10.f;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = 58;
    CGRect frame = CGRectMake(0, 0, screenW, screenH);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_collectionFlowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
