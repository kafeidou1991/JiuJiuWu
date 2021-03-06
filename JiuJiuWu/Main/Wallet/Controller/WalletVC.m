//
//  WalletVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "WalletVC.h"
#import "HomeHeaderView.h"
#import "FeatureListView.h"
#import "CashKeyBoradVC.h"
#import "LevelUpVC.h"
#import "QRPayCodeWebVC.h"
#import "QRPayCodeVC.h"
#import "QuickPayVC.h"
#import "CreditCardInfoVC.h"
#import "IncomeListVC.h"
#import "MyShopsVC.h"
#import "BalanceVC.h"
#import "MyRateVC.h"
#import "LuckyDrawVC.h"
#import "AdvertiseItem.h"

#import "FZMWalletBannerCell.h"
#import "FZMWalletFunctionCell.h"
#import "FZMWalletHeaderCell.h"

#import "FZMMyCreditCardController.h"

#import "ServiceVC.h"
#import "ShareVC.h"
#import "UpgradeWebVC.h"


static CGFloat const kHeaderCellH = 120; //顶部视图高度

@interface WalletVC ()<QMUITableViewDataSource,QMUITableViewDelegate>

@property (nonatomic, strong) Version_App * version;
@property (nonatomic, strong) NSArray * adsImageArray;


@property (strong, nonatomic) QMUITableView *tableView;

@property (assign, nonatomic) CGFloat kBannerCellH;
@property (assign, nonatomic) CGFloat kFunctionCellH;

/** 顶部视图 */

@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configNavigation];
    
    [self initializeDataSource];
    //检查更新
    [self checkAppVersion];
}

- (void)initializeDataSource{
    _kBannerCellH = 0;
    _kFunctionCellH = 0;
}

- (void)configNavigation{
//    self.title = @"九九吾";
    
    QMUINavigationButton *leftButton = [QMUINavigationButton buttonWithTitle:@" 交易记录" titleColor:nil font:nil imageName:@"Wallet_nav_order" target:self action:@selector(orderQueryAction)];
    leftButton.frame = CGRectMake(0, 0, 90, 20);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    QMUINavigationButton *rightButton = [QMUINavigationButton buttonWithTitle:@" 客服" titleColor:nil font:nil imageName:@"Wallet_nav_message" target:self action:@selector(customerServiceAction)];
    rightButton.frame = CGRectMake(0, 0, 50, 20);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)configTableView{
    [self.view addSubview:self.tableView];
}

#pragma mark ------代理-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeakSelf
    
    if (indexPath.section == 0) {
        FZMWalletHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FZMWalletHeaderCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setHederBlock:^(NSInteger index){
            [weakSelf headerAction:index];
        }];
        
        return cell;
    } else if (indexPath.section == 2){
        FZMWalletFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FZMWalletFunctionCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setTypeBlock:^(JJWSelectType type){
            [weakSelf functionAction:type];
        }];
        
        [cell configVersonIsOpen:[self.version.is_open boolValue]];
//        [cell configVersonIsOpen:YES];
        
        return cell;
    } else {
        FZMWalletBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FZMWalletBannerCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configItem:self.adsImageArray];
        
        [cell setBannerBlock:^(NSString *linkUrl){
            [weakSelf bannerAction:linkUrl];
        }];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kHeaderCellH;
    } else if (indexPath.section == 2){
        return _kFunctionCellH+kJJWDefaultMargin;
    } else {
        return _kBannerCellH;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 2 ? kJJWDefaultMargin : 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView qmui_clearsSelection];
}

#pragma mark ------lazyLoad-------
- (QMUITableView *)tableView{
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBarHeight - StatusBarHeight - TabBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = kJJWBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[FZMWalletHeaderCell class] forCellReuseIdentifier:NSStringFromClass([FZMWalletHeaderCell class])];
        [_tableView registerClass:[FZMWalletBannerCell class] forCellReuseIdentifier:NSStringFromClass([FZMWalletBannerCell class])];
        [_tableView registerClass:[FZMWalletFunctionCell class] forCellReuseIdentifier:NSStringFromClass([FZMWalletFunctionCell class])];
    }
    
    return _tableView;
}

#pragma mark ------网络加载-------
- (void)checkAppVersion{
    WeakSelf
    [self checkVersion:^(Version_App * version) {
        weakSelf.version = version;
        if (version.is_open.integerValue == 1) {
            //获取广告列表
            [weakSelf getIds];
        } else {
            weakSelf.kFunctionCellH = SCREEN_WIDTH/4;
            weakSelf.kBannerCellH = 0;
            [weakSelf configTableView];
        }
    }];
}

-(void)getIds {
    WeakSelf
    [JJWNetworkingTool GetWithUrl:GetIndex params:@{} isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        weakSelf.adsImageArray = [NSArray yy_modelArrayWithClass:[AdvertiseItem class] json:responseObject[@"ad"]];
        
        weakSelf.kBannerCellH = kJJWArrayIsEmpty(weakSelf.adsImageArray) ? 0 : 100;
        weakSelf.kFunctionCellH = SCREEN_WIDTH/2;

        [weakSelf configTableView];
    } failed:^(NSError *error, id chaceResponseObject) {
        [JJWBase alertMessage:error.domain cb:nil];
        weakSelf.kBannerCellH = 0;
        weakSelf.kFunctionCellH = SCREEN_WIDTH/2;
        [weakSelf configTableView];
    }];
}

#pragma mark ------action-------

/**
 支付方式选择
 */
- (void)headerAction:(NSInteger)index{
    [[JJWLogin sharedMethod]checkInfo:self complete:^{
        if (index == 0) {
            CashKeyBoradVC * VC = [[CashKeyBoradVC alloc]init];
            VC.payType = index;
            [self.navigationController pushViewController:VC animated:YES];
        }else if (index == 1){
//            if (self.version.is_open.integerValue == 1) {
//                FZMMyCreditCardController *creditCardVC = [[FZMMyCreditCardController alloc] init];
//                [self.navigationController pushViewController:creditCardVC animated:YES];
//            } else {
//                MyRateVC * VC = [[MyRateVC alloc]init];
//                VC.isQuickPay = YES;
//                [self.navigationController pushViewController:VC animated:YES];
//            }
            MyRateVC * VC = [[MyRateVC alloc]init];
            VC.isQuickPay = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (index == 2){
            [[JJWInitApp sharedMethod]initApp:^(Version_App * app) {
                if (app.is_open.integerValue == 0) {
                    QRPayCodeVC * VC = [[QRPayCodeVC alloc]init];
                    [self.navigationController pushViewController:VC animated:YES];
                }else {
                    QRPayCodeWebVC * VC = [[QRPayCodeWebVC alloc]init];
                    VC.urlString = QRPayCode;
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }];
        }
        
    }];

}

/**
 广告图选择
 */
- (void)bannerAction:(NSString *)linkUrlStr{
    JJWWebViewVC * VC = [[JJWWebViewVC alloc]init];
    VC.urlString = linkUrlStr;
    VC.isHiddenBottom = YES;
    VC.isAllowTitle = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


/**
 功能模块选择
 */
- (void)functionAction:(JJWSelectType)type {
    [[JJWLogin sharedMethod]checkInfo:self complete:^{
        if (type == JJWSelectType_MyAccount) {
            BalanceVC * VC = [[BalanceVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_MyProfit){
            IncomeListVC * VC = [[IncomeListVC alloc]init];
            VC.type = ListType_MyCashDis;
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_Share){
            ShareVC * VC = [[ShareVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_MyShop){
            MyShopsVC * VC = [[MyShopsVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_MyLucky){
            LuckyDrawVC * VC = [[LuckyDrawVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_LeveUp){
            //            LevelUpVC * VC = [[LevelUpVC alloc]init];
            //            [self.navigationController pushViewController:VC animated:YES];
            UpgradeWebVC * VC = [[UpgradeWebVC alloc]init];
            VC.urlString = LevelUpURL;
            VC.isHiddenBottom = YES;
            VC.title = @"我要升级";
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_Loan) {
            JJWWebViewVC * VC = [[JJWWebViewVC alloc]init];
            VC.urlString = LoanURL;
            VC.isHiddenBottom = YES;
            VC.title = @"信用贷";
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_CreditCard){
            JJWWebViewVC * VC = [[JJWWebViewVC alloc]init];
            VC.urlString = JJWApplyForCreditCardURL;
            VC.isHiddenBottom = YES;
            VC.title = @"申请信用卡";
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == JJWSelectType_PayList) {
            IncomeListVC * VC = [[IncomeListVC alloc]init];
            VC.type = ListType_Income;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
}

/**
 订单查询
 */
- (void)orderQueryAction{
    [self functionAction:JJWSelectType_PayList];
}

/**
 客服联系
 */
- (void)customerServiceAction{
    ServiceVC * serviceVC = [ServiceVC new];
    [self.navigationController pushViewController:serviceVC animated:NO];
}

@end
