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
#import "QRPayCodeVC.h"
#import "QuickPayVC.h"
#import "CreditCardInfoVC.h"
#import "IncomeListVC.h"
#import "QuickPayWebVC.h"
#import "MyShopsVC.h"
#import "BalanceVC.h"
#import "MyRateVC.h"

static CGFloat const headerHeight = 220; //顶部视图高度

@interface WalletVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * backView;
@property (nonatomic, strong) HomeHeaderView * headerView;
@property (nonatomic, strong) FeatureListView * centerView;
@property (nonatomic, strong) UIImageView * bannerImageView;
@property (nonatomic, strong) Version_App * version;

@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.delegate = self;
    self.navigationItem.leftBarButtonItem = nil;
    [self addSubViews];
    //检查更新
    WeakSelf
    [self checkVersion:^(Version_App * version) {
        weakSelf.version = version;
        [self.backView addSubview:self.centerView];
        if (version.is_open.integerValue == 1) {
            [self.backView addSubview:self.bannerImageView];
            [self.backView setContentSize:CGSizeMake(SCreenWidth, _bannerImageView.bottom + 10)];
        }else {
            [self.backView setContentSize:CGSizeMake(SCreenWidth, _centerView.bottom + 10)];
        }
    }];
}

- (void)addSubViews {
    [self.view addSubview:self.backView];
    [self.backView setContentInset:UIEdgeInsetsMake(headerHeight, 0, 0, 0)];
    [self.backView addSubview:self.headerView];
}
- (void)_gotoVC:(SelectType)type {
    [[JJWLogin sharedMethod]checkInfo:self complete:^{
        if (type == SelectType_MyAccount) {
            BalanceVC * VC = [[BalanceVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == SelectType_MyProfit){
            IncomeListVC * VC = [[IncomeListVC alloc]init];
            VC.type = ListType_MyCashDis;
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == SelectType_PayList){
            //收款记录
            IncomeListVC * VC = [[IncomeListVC alloc]init];
            VC.type = ListType_Income;
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == SelectType_MyShop){
            MyShopsVC * VC = [[MyShopsVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == SelectType_MyRate){
            MyRateVC * VC = [[MyRateVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == SelectType_LeveUp){
//            LevelUpVC * VC = [[LevelUpVC alloc]init];
//            [self.navigationController pushViewController:VC animated:YES];
            JJWWebViewVC * VC = [[JJWWebViewVC alloc]init];
            VC.urlString = LevelUpURL;
            VC.isHiddenBottom = YES;
            VC.title = @"我要升级";
            [self.navigationController pushViewController:VC animated:YES];
        }else if (type == SelectType_Loan || type == SelectType_Money || type == SelectType_More){
            [self jxt_showAlertWithTitle:@"温馨提示" message:@"攻城狮正在玩命开发中..." appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.addActionCancelTitle(@"我知道了");
            } actionsBlock:nil];
        }
    }];
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
-(UIScrollView *)backView {
    if (!_backView) {
        UIScrollView * backScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, SCreenWidth, SCreenHegiht - kTabBarHeight)];
        backScrollerView.delegate = self;
        backScrollerView.showsVerticalScrollIndicator = NO;
        backScrollerView.showsHorizontalScrollIndicator = NO;
        backScrollerView.backgroundColor = CommonBackgroudColor;
        _backView = backScrollerView;
    }
    return _backView;
}

-(HomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:self options:nil].firstObject;
        _headerView.frame = CGRectMake(0,-headerHeight, SCreenWidth, headerHeight);
        WeakSelf
        _headerView.block = ^(NSInteger index) {
            [[JJWLogin sharedMethod]checkInfo:weakSelf complete:^{
                if (index == 0) {
                    CashKeyBoradVC * VC = [[CashKeyBoradVC alloc]init];
                    VC.payType = index;
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                }else if (index == 1){
                    QuickPayWebVC * VC = [[QuickPayWebVC alloc]init];
                    VC.urlString = QuickPayUrl;
                    VC.isHiddenBottom = YES;
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                }else if (index == 2){
                    QRPayCodeVC * VC = [[QRPayCodeVC alloc]init];
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                }
                
            }];
        };
    }
    return _headerView;
}

-(FeatureListView *)centerView {
    if (!_centerView) {
        NSArray * array = @[];
        if (self.version.is_open.integerValue == 1) {
           array = @[@{@"image":@"featurelist_0",@"title":@"我的账户"},
                @{@"image":@"featurelist_1",@"title":@"我的分润"},
                @{@"image":@"featurelist_2",@"title":@"交易记录"},
                @{@"image":@"featurelist_3",@"title":@"我的商户"},
                @{@"image":@"featurelist_4",@"title":@"我的费率"},
                @{@"image":@"featurelist_5",@"title":@"我要升级"},
                @{@"image":@"featurelist_6",@"title":@"贷款"},
                @{@"image":@"featurelist_7",@"title":@"理财"},
                @{@"image":@"featurelist_8",@"title":@"更多"}];
        }else {
            array = @[@{@"image":@"featurelist_2",@"title":@"交易记录"}];
        }
        _centerView = [[FeatureListView alloc]initWithFrame:CGRectMake(0, _headerView.bottom - 40, SCreenWidth, 0) DataSourse:array];
        WeakSelf
        _centerView.typeBlock = ^(SelectType type) {
            [weakSelf _gotoVC:type];
        };
    }
    return _centerView;
}
-(UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(11, _centerView.bottom + 10, SCreenWidth - 2 * 11, 100)];
        _bannerImageView.image = [UIImage imageNamed:@"banner_image"];
    }
    return _bannerImageView;
}



@end
