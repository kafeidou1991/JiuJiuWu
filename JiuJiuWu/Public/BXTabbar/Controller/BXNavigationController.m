//
//  BXNavigationController.m
//  BaoXianDaiDai
//
//  Created by JYJ on 15/5/28.
//  Copyright (c) 2015年 baobeikeji.cn. All rights reserved.
//

#import "BXNavigationController.h"
#import "UIImage+Extension.h"
//#import "YZFWebViewController.h"

@interface BXNavigationController () <UINavigationControllerDelegate,UINavigationBarDelegate>

//调用webView时用
/**
 *  由于 popViewController 会触发 shouldPopItems，因此用该布尔值记录是否应该正确 popItems
 */
@property BOOL shouldPopItemAfterPopViewController;


@end

@implementation BXNavigationController

+ (void)initialize {
//    // 设置UIUINavigationBar的主题
//    [self setupNavigationBarTheme];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    self.shouldPopItemAfterPopViewController = NO;
    
    // 设置UIUINavigationBar的主题
    [self setupNavigationBarTheme];
}

/**
 *  设置UIBarButtonItem的主题
 */
- (void)setupNavigationBarTheme {
    // 通过appearance对象能修改整个项目中所有UIBarbuttonItem的样式
    UINavigationBar *appearance = self.navigationBar;//[UINavigationBar appearance];
    
    // 1.设置导航条的背景
    [appearance setBackgroundImage:[UIImage createImageWithColor:JJWThemeColor] forBarMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[UIImage new]];
    // 设置文字
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:att];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = JJWThemeColor;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        
        //设置导航栏的按钮
        //       UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"navigationbar_back_image" highImageName:@"navigationbar_back_image" target:self action:@selector(back)];
        //        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, BLACKBAR_BUTTON];
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark -

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


-(UIViewController*)popViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToViewController:viewController animated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToRootViewControllerAnimated:animated];
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    
    //! 如果应该pop，说明是在 popViewController 之后，应该直接 popItems
    if (self.shouldPopItemAfterPopViewController) {
        self.shouldPopItemAfterPopViewController = NO;
        return YES;
    }
    
    //! 如果不应该 pop，说明是点击了导航栏的返回，这时候则要做出判断区分是不是在 webview 中
//    if ([self.topViewController isKindOfClass:[YZFWebViewController class]]) {
//        YZFWebViewController* webVC = (YZFWebViewController*)self.viewControllers.lastObject;
//        if (webVC.webView.canGoBack) {
//            [webVC.webView goBack];
//            
//            //!make sure the back indicator view alpha back to 1
//            self.shouldPopItemAfterPopViewController = NO;
//            [[self.navigationBar subviews] lastObject].alpha = 1;
//            return NO;
//        }else{
//            [self popViewControllerAnimated:YES];
//            return NO;
//        }
//    }else{
//        [self popViewControllerAnimated:YES];
//        return NO;
//    }
    
    [self popViewControllerAnimated:YES];
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
