//
//  MyDelegateViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "MyShopsVC.h"
#import "KTDropdownMenuView.h"
#import "MyShopListCell.h"


typedef NS_ENUM(NSInteger, MyShopsType) {
    MyInviteShopsType = 0, //邀请商户
    MyDistrictsShopsType, //区县代理
    MyUpgradeShopsType //升级代理
};

@interface MyShopsVC ()

@property (nonatomic, assign) MyShopsType selectType;
@property (nonatomic, assign) MyShopsType lastSelectType;
@property (nonatomic, strong) KTDropdownMenuView *menuView;

@end

@implementation MyShopsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的商户";
    self.selectType = self.lastSelectType = MyInviteShopsType;
    [self createNavgationView];
}
- (void)createNavgationView {
    NSArray *titles = @[@"推荐商户", @"区县代理",@"升级代理"];
    self.menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
    self.menuView.cellColor =JJWThemeColor;
    self.menuView.cellSeparatorColor = [UIColor whiteColor];
    WeakSelf
    self.menuView.selectedAtIndex = ^(int index){
        weakSelf.selectType = index;
        [weakSelf afterProFun];
    };
    self.menuView.width = 300;
    self.navigationItem.titleView = self.menuView;
}
-(void)afterProFun{
    [self hudShow:self.view msg:STTR_ater_on];
    NSString * searchType = @"1";
    if (self.selectType == MyInviteShopsType) {
        searchType = @"1";
    }else if (self.selectType == MyDistrictsShopsType) {
        searchType = @"2";
    }else if (self.selectType == MyUpgradeShopsType) {
        searchType = @"4";
    }
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,@"user_id":[JJWLogin sharedMethod].loginData.user_id,@"searchtype":searchType};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:MyShopsLeader params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        self.lastSelectType = self.selectType;
        self.dataSources = [NSArray yy_modelArrayWithClass:[MyShopItem class] json:responseObject].mutableCopy;
        if (self.dataSources.count > 0) {
            [self createTableView];
        }else {
            [self createEmptyView];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        weakSelf.menuView.selectedIndex = self.lastSelectType;
        self.selectType = self.lastSelectType;
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void)refreshAction {
    [self afterProFun];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdenfi = @"myShopId";
    MyShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfi];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MyShopListCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyShopItem * item = [self.dataSources objectAtIndex:indexPath.row];
    [cell updateCell:item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}


@end
