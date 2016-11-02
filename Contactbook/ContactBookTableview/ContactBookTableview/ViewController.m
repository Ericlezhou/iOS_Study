//
//  ViewController.m
//  ContactBookTableview
//
//  Created by Eric on 2016/11/1.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    CGPoint _beginPoint;
    UIPanGestureRecognizer *_gesture;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *touchView;
@property (strong, nonatomic) UIButton *indicatorView;
@property (strong, nonatomic) UILabel *tipsView;
@property (nonatomic, strong) NSTimer *checkClickTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    
    _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction:)];
    
    [_touchView addGestureRecognizer:_gesture];
    
    _indicatorView = [[UIButton alloc] init];
    _indicatorView.backgroundColor = [UIColor redColor];
    _indicatorView.frame = CGRectMake(0, 0, 10, 30);
    [_indicatorView addTarget:self action:@selector(showTip:) forControlEvents:UIControlEventTouchDown];
    [_indicatorView addTarget:self action:@selector(hideTip:) forControlEvents:UIControlEventTouchUpInside];
    [_touchView addSubview:_indicatorView];
    
    _tipsView = [[UILabel alloc] init];
    _tipsView.hidden = YES;
    _tipsView.numberOfLines = 1;
    _tipsView.textColor = [UIColor greenColor];
    _tipsView.backgroundColor = [UIColor redColor];
    [_touchView addSubview:_tipsView];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self refreshIndicatorFrame];
}

- (void)refreshIndicatorFrame{
    CGFloat tableViewH = _tableview.bounds.size.height;
    CGFloat contentH = _tableview.contentSize.height;
    if (!contentH) {
        return;
    }
    CGFloat indicatorH = ceilf((tableViewH / contentH) * tableViewH);
    CGFloat tableviewContentY = _tableview.contentOffset.y;
    CGFloat indicatorY = ceilf((tableviewContentY / contentH) * tableViewH);
    
    _indicatorView.frame = CGRectMake(0, indicatorY, 10, indicatorH);

    
    CGFloat tipViewX = _indicatorView.frame.origin.x - 50;
    CGFloat tipViewY = _indicatorView.frame.origin.y + (_indicatorView.frame.size.height - 20) / 2.0;
    _tipsView.frame = CGRectMake(tipViewX, tipViewY, 40, 20);
    UITableViewCell *cell = [_tableview.visibleCells firstObject];
    _tipsView.text = cell.textLabel.text;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - timer
- (void)startCheckTimer
{
    if (!self.checkClickTimer) {
        self.checkClickTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(hideTip:) userInfo:nil repeats:YES];
    }
}

- (void)destroyCheckTimer{
    if ([self.checkClickTimer isValid]) {
        [self.checkClickTimer invalidate];
    }
    self.checkClickTimer = nil;
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f", _tableview.contentOffset.y);
    [self refreshIndicatorFrame];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!_tipsView.hidden) {
        _tipsView.hidden = YES;
    }
}

- (void)showTip:(id) sender{
    if (_tipsView.hidden) {
        _tipsView.hidden = NO;
    }
    [self startCheckTimer];
}

- (void)hideTip:(id) sender{
    if(!_gesture.numberOfTouches){
        if (!_tipsView.hidden) {
            _tipsView.hidden = YES;
        }
        [self destroyCheckTimer];
    }
}

- (void)touchAction:(UIPanGestureRecognizer *)gesture{
    
    CGFloat tableViewH = _tableview.bounds.size.height;
    CGFloat contentH = _tableview.contentSize.height;
    if (!tableViewH) {
        return;
    }
    
    CGPoint point = [gesture locationInView:_touchView];
    if (point.y >= _indicatorView.frame.origin.y && point.y <= _indicatorView.frame.origin.y + _indicatorView.frame.size.height ) {
        if (gesture.state == UIGestureRecognizerStateBegan ) {
            _beginPoint = point;
            [self showTip:nil];
        }else if(gesture.state == UIGestureRecognizerStateChanged){
            [self showTip:nil];
        }
        else{
            [self hideTip:nil];
        }
        NSLog(@"%ld",gesture.state);
        
        CGFloat tableViewOffsetY = _tableview.contentOffset.y;
        CGFloat y = tableViewOffsetY + (point.y - _beginPoint.y) * contentH / tableViewH;
        if (y < 0) {
            y = 0;
        }else if (y > _tableview.contentSize.height - _tableview.bounds.size.height){
            y = _tableview.contentSize.height - _tableview.bounds.size.height;
        }
        [_tableview setContentOffset:CGPointMake(0, y)];
        
        _beginPoint = point;
    }
}

@end
