//
//  BXTabBarController.m
//  BaoXianDaiDai
//
//  Created by JYJ on 15/5/28.
//  Copyright (c) 2015年 baobeikeji.cn. All rights reserved.
//

#import "BXTabBarController.h"
#import "BXNavigationController.h"
#import "BXTabBar.h"

#import "WalletVC.h"
#import "ShareVC.h"
#import "ShareWebVC.h"
#import "MeCenterVC.h"


@interface BXTabBarController ()<UITabBarControllerDelegate, UINavigationControllerDelegate, BXTabBarDelegate>

@property (nonatomic, assign) NSInteger lastSelectIndex;
@property (nonatomic, strong) UIView *redPoint;
/** view */
@property (nonatomic, strong) BXTabBar *mytabbar;

@property (nonatomic, strong) id popDelegate;
/** 保存所有控制器对应按钮的内容（UITabBarItem）*/
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation BXTabBarController
+ (void)initialize {
    // 设置tabbarItem的普通文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    
    //设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = themeColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
}


- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    // 把系统的tabBar上的按钮干掉
    [self.tabBar removeFromSuperview];
    // 把系统的tabBar上的按钮干掉
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[BXTabBar class]]) {
            [childView removeFromSuperview];
            
        }
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 添加所有子控制器
    [self addAllChildVc];
    // 自定义tabBar
    [self setUpTabBar];
    // 设置选中一定要在设置完tabBar以后, 默认选中第0个
    // self.selectedIndex = 0;
    
    //    self.tabBar.shadowImage = [[UIImage alloc] init];
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar
{
    BXTabBar *tabBar = [[BXTabBar alloc] init];
    // 存储UITabBarItem
    tabBar.items = self.items;
    
    tabBar.delegate = self;
    
    tabBar.backgroundColor = [UIColor whiteColor];
    
    tabBar.frame = self.tabBar.frame;
    [self.view addSubview:tabBar];
    self.mytabbar = tabBar;
}


/**
 *  添加所有的子控制器
 */
- (void)addAllChildVc {
    // 添加初始化子控制器 BXHomeViewController
    WalletVC *moduleHomeVC = [[WalletVC alloc] init];
    [self addOneChildVC:moduleHomeVC title:@"钱包" imageName:@"tabBar_wallet" selectedImageName:@"tabBar_wallet_Select"];
//    ShareWebVC *mainCourseVC = [[ShareWebVC alloc]init];
    ShareVC *mainCourseVC = [[ShareVC alloc]init];
    [self addOneChildVC:mainCourseVC title:@"分享" imageName:@"tabBar_share" selectedImageName:@"tabBar_share_Select"];
    
    MeCenterVC *meCenterVC = [[MeCenterVC alloc] init];
    [self addOneChildVC:meCenterVC title:@"我的" imageName:@"tabBar_my" selectedImageName:@"tabBar_my_Select"];
}


/**
 *  添加一个自控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.tabBarItem.title = title;
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
//    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = [selectedImage imageWithTintColor:themeColor];
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:childVc.tabBarItem];
    
    // 添加为tabbar控制器的子控制器
    BXNavigationController *nav = [[BXNavigationController alloc] initWithRootViewController:childVc];
    nav.delegate = self;
    [self addChildViewController:nav];
}

#pragma mark - BXTabBarDelegate方法
// 监听tabBar上按钮的点击
- (void)tabBar:(BXTabBar *)tabBar didClickBtn:(NSInteger)index
{
    [super setSelectedIndex:index];
}

/**
 *  让myTabBar选中对应的按钮
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    // 通过mytabbar的通知处理页面切换
    self.mytabbar.seletedIndex = selectedIndex;
}


#pragma mark navVC代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    self.tabBar.hidden = YES;
    if (viewController != root) {
        //从HomeViewController移除
        [self.mytabbar removeFromSuperview];
        // 调整tabbar的Y值
        CGRect dockFrame = self.mytabbar.frame;
        dockFrame.origin.y = root.view.frame.size.height;
        //        if ([root isKindOfClass:[MeCenterViewController class]]) {
        //            dockFrame.origin.y = root.view.frame.size.height - kTabBarHeight;
        //        }
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是能滚动
            UIScrollView *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y += scrollview.contentOffset.y;
        }
        self.mytabbar.frame = dockFrame;
        // 添加dock到根控制器界面
        [root.view addSubview:self.mytabbar];
    }
    //隐藏导航栏再次出操作
    if ([viewController isKindOfClass:[WalletVC class]] ||
        [viewController isKindOfClass:[MeCenterVC class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

// 完全展示完调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    BXNavigationController *nav = (BXNavigationController *)navigationController;
    if (viewController == root) {
        // 更改导航控制器view的frame
        //        navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kTabBarHeight);
        
        navigationController.interactivePopGestureRecognizer.delegate = nav.popDelegate;
        // 让Dock从root上移除
        [_mytabbar removeFromSuperview];
        
        //_mytabbar添加dock到HomeViewController
        //        _mytabbar.frame = self.tabBar.frame;
        CGRect frame = self.tabBar.frame;
        frame.size.width = SCreenWidth;
        frame.origin.y = SCreenHegiht - frame.size.height;
        frame.origin.x = 0;
        self.mytabbar.frame = frame;
        [self.view addSubview:self.mytabbar];
    }
}

#pragma mark -

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end
