//
//  ShareVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ShareVC.h"
#import "ShareCell.h"

static CGFloat const space =10.f;

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [JJWBase createCustomBarButtonItem:self action:@selector(list) title:@"转账记录"];
    self.view.backgroundColor = CommonBackgroudColor;
    self.dataSources = @[@{@"image":@"share_0",@"title":@"分享二维码图片链接"},
                        @{@"image":@"share_1",@"title":@"朋友圈中央文案库"},
                        @{@"image":@"share_2",@"title":@"分享注册邀请链接"},
                        @{@"image":@"share_3",@"title":@"分享注册邀请链接"},
                        @{@"image":@"share_4",@"title":@"面对面开通账户"},
                        @{@"image":@"share_5",@"title":@"视频教程"}].mutableCopy;
    [self createGroupTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(space, 0, SCreenWidth - 2 * space, SCreenHegiht - NAVIGATION_BAR_HEIGHT - kTabBarHeight);
    self.tableView.backgroundColor = [UIColor clearColor];
}
- (void)list {
    
}
#pragma mark - tableiView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

-(ShareCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    ShareCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ShareCell" owner:self options:nil].firstObject;
    }
    [cell updateCell:self.dataSources[indexPath.section]];
    return cell;
}





@end
