//
//  MeCenterVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "MeCenterVC.h"
#import "LoginVC.h"
#import "MeCenterHeadView.h"
#import "ShareCell.h"

static CGFloat const headerHeight = 220; //顶部视图高度
static CGFloat const space =11.f;

@interface MeCenterVC ()<UINavigationControllerDelegate>

@property (nonatomic, strong) MeCenterHeadView * headerView;

@end

@implementation MeCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.delegate = self;
    
    
    self.view.backgroundColor = CommonBackgroudColor;

    self.dataSources = @[@{@"image":@"share_0",@"title":@"分享二维码图片链接"},
                         @{@"image":@"share_1",@"title":@"朋友圈中央文案库"},
                         @{@"image":@"share_2",@"title":@"分享注册邀请链接"},
                         @{@"image":@"share_3",@"title":@"分享注册邀请链接"},
                         @{@"image":@"share_4",@"title":@"面对面开通账户"},
                         @{@"image":@"share_5",@"title":@"视频教程"}].mutableCopy;
    [self createTableView];
    self.tableView.frame = CGRectMake(0, 0, SCreenWidth, SCreenHegiht - NAVIGATION_BAR_HEIGHT - kTabBarHeight);
    [self.tableView setContentInset:UIEdgeInsetsMake(headerHeight, 0, 0, 0)];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:self.headerView];
    self.tableView.clipsToBounds = YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}


-(ShareCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    ShareCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ShareCell" owner:self options:nil].firstObject;
    }
    [cell updateCell:self.dataSources[indexPath.row]];
    return cell;
}
#pragma mark - scrollerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    if (point.y < - headerHeight) {
        CGRect rect = _headerView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        _headerView.frame = rect;
    }
}
#pragma mark - initUI
-(MeCenterHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"MeCenterHeadView" owner:self options:nil].firstObject;
        _headerView.frame = CGRectMake(0,-headerHeight, SCreenWidth, headerHeight);
    }
    return _headerView;
}


//设置导航栏隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHome = [viewController isKindOfClass:[self class]];
    [navigationController setNavigationBarHidden:isHome animated:YES];
};







//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 50, 50);
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//- (void)login {
//    [LoginVC OpenLogin:self callback:^(BOOL compliont) {
//
//    }];
//
//}



@end
