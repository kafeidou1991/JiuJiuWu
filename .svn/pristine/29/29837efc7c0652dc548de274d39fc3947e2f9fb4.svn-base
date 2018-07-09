//
//  AppDelegate.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "AppDelegate.h"
#import "BXTabBarController.h"
#import "BXNavigationController.h"
#import "HcdGuideView.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()
@property (nonatomic, strong) BXTabBarController * tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 设置窗口的根控制器
    self.window.rootViewController = self.tabBarController;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //初始化bugly
    // 去除键盘上的工具栏
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enableAutoToolbar= NO;
    keyboardManager.shouldResignOnTouchOutside = YES;
    //引导页
//    [self _guidePage];
    return YES;
}
-(BXTabBarController *)tabBarController{
    if (!_tabBarController) {
        _tabBarController = [[BXTabBarController alloc]init];
    }
    return _tabBarController;
}
- (void)setupBugly {
    [Bugly startWithAppId:@"fa0e94eabc"];
}
//引导页
- (void) _guidePage{
    NSMutableArray *images = [NSMutableArray new];
    [images addObject:[UIImage imageNamed:@"guide_1"]];
    [images addObject:[UIImage imageNamed:@"guide_2"]];
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
