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

static CGFloat const headerHeight = 220; //顶部视图高度

@interface WalletVC ()<UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * backView;
@property (nonatomic, strong) HomeHeaderView * headerView;
@property (nonatomic, strong) FeatureListView * centerView;
@property (nonatomic, strong) UIImageView * bannerImageView;

@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    self.navigationItem.leftBarButtonItem = nil;
    [self addSubViews];
    
    
    
    
}
- (void)addSubViews {
    [self.view addSubview:self.backView];
    [self.backView setContentInset:UIEdgeInsetsMake(headerHeight, 0, 0, 0)];
    [self.backView addSubview:self.headerView];
    [self.backView addSubview:self.centerView];
    [self.backView addSubview:self.bannerImageView];
    [self.backView setContentSize:CGSizeMake(SCreenWidth, _bannerImageView.bottom + 10)];
    
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
    }
    return _headerView;
}

-(FeatureListView *)centerView {
    if (!_centerView) {
        NSArray * array = @[@{@"image":@"featurelist_0",@"title":@"我的账户"},
                            @{@"image":@"featurelist_1",@"title":@"我的分润"},
                            @{@"image":@"featurelist_2",@"title":@"交易记录"},
                            @{@"image":@"featurelist_3",@"title":@"我的商户"},
                            @{@"image":@"featurelist_4",@"title":@"我的费率"},
                            @{@"image":@"featurelist_5",@"title":@"我要升级"},
                            @{@"image":@"featurelist_6",@"title":@"贷款"},
                            @{@"image":@"featurelist_7",@"title":@"理财"},
                            @{@"image":@"featurelist_8",@"title":@"更多"}];
        _centerView = [[FeatureListView alloc]initWithFrame:CGRectMake(0, _headerView.bottom - 40, SCreenWidth, 0) DataSourse:array];
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





//设置导航栏隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHome = [viewController isKindOfClass:[self class]];
    [navigationController setNavigationBarHidden:isHome animated:YES];
};






















@end
