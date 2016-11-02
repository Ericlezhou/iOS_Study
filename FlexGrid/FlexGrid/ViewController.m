//
//  ViewController.m
//  FlexGrid
//
//  Created by Eric on 16/10/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "FlexGridCell.h"

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
    _collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionFlowLayout.minimumLineSpacing = 10.f;
    _collectionFlowLayout.minimumInteritemSpacing = 10.f;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenH = 58;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGRect frame = CGRectMake(10, 40, screenW - 20, screenH);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_collectionFlowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[FlexGridCell class] forCellWithReuseIdentifier:@"FlexGridCell"];
    [self.view addSubview:_collectionView];
    [_collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size =  [FlexGridCell makeSizeWithTextStr:_dataModel[indexPath.row]];
    NSLog(@"%f, %f", size.width, size.height);
    return size;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", _dataModel[indexPath.row]);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataModel.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FlexGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlexGridCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[FlexGridCell alloc] initWithFrame:CGRectZero];
    }
    [cell setObj:_dataModel[indexPath.row]];
    return cell;
}



@end
