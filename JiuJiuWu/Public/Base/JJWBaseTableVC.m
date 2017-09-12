//
//  JJWBaseTableVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseTableVC.h"

@interface JJWBaseTableVC ()

@end

@implementation JJWBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSources = self.dataSources.count > 0 ? self.dataSources : @[].mutableCopy;
    self.view.backgroundColor = [UIColor whiteColor];
    currPage = 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}

- (void)createTableView{
    if (_emptyView && [self.view.subviews containsObject:_emptyView]) {
        [_emptyView removeFromSuperview]; _emptyView = nil;
    }
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = CellLine_Color;
        _tableView.backgroundColor = CommonBackgroudColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    if (![self.view.subviews containsObject:_tableView]) {
        [self.view addSubview:_tableView];
    }else{
        [_tableView reloadData];
    }
}
- (void)createGroupTableView{
    if (_emptyView && [self.view.subviews containsObject:_emptyView]) {
        [_emptyView removeFromSuperview]; _emptyView = nil;
    }
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = CellLine_Color;
        _tableView.backgroundColor = CommonBackgroudColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    if (![self.view.subviews containsObject:_tableView]) {
        [self.view addSubview:_tableView];
    }else{
        [_tableView reloadData];
    }
}
- (void)createEmptyView{
    if (_tableView && [self.view.subviews containsObject:_tableView]) {
        [_tableView removeFromSuperview];_tableView =nil;
    }
    if (!_emptyView) {
        _emptyView = [[SUEmptyView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT)];
        [_emptyView setDestext:@"暂无数据!"];
    }
    if (![self.view.subviews containsObject:_emptyView]) {
        [self.view addSubview:_emptyView];
    }
}
- (void)addHeaderRefesh:(BOOL)isRightNow Block:(MJRefreshComponentRefreshingBlock)block{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currPage = 1;
        if (block) {
            block();
        }
        if (self.tableView.mj_footer && self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            self.tableView.mj_footer.state = MJRefreshStateIdle;
        }
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    if (isRightNow) {
        [header beginRefreshing];
    }
    // 设置header
    self.tableView.mj_header = header;
    
}

-(void)addFooterRefesh:(MJRefreshComponentRefreshingBlock)block{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        currPage ++;
        if (block) {
            block();
        }
    }];
}

- (void)endRefesh:(BOOL)isHeader{
    if (isHeader) {
        if (self.tableView.mj_header) {
            [self.tableView.mj_header endRefreshing];
        }
    }else{
        if (self.tableView.mj_footer) {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

-(void)noHasMoreData{
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 60)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = themeColor;
    btn.showsTouchWhenHighlighted = NO;
    btn.layer.cornerRadius = 5;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
        if (block) {
            block(x);
        }
    }];
    btn.frame = CGRectMake(8, 10, SCreenWidth - 2 * 8, 40);
    [view addSubview:btn];
    return view;
}






@end
