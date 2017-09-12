//
//  JJWBaseTableVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseVC.h"
#import "MJRefresh.h"

@interface JJWBaseTableVC : JJWBaseVC <UITableViewDataSource,UITableViewDelegate> {
    NSInteger currPage;//当前页数
}

/** tableview */
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;


//设置头刷新
- (void)addHeaderRefesh:(BOOL)isRightNow Block:(MJRefreshComponentRefreshingBlock)block;
//设置底部加载
- (void)addFooterRefesh:(MJRefreshComponentRefreshingBlock)block;
//结束刷新
- (void)endRefesh:(BOOL)isHeader;

- (void)noHasMoreData;

- (void)createTableView;
- (void)createGroupTableView;

- (void)createEmptyView;


- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block;


@end
