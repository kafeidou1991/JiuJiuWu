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
#import "CTShareTool.h"

#import "QMUIConfigurationTemplate.h"
#import "CLLockVC.h"
#import "ScrollLabelHelp.h"

//#import <PgySDK/PgyManager.h>
//#import <PgyUpdate/PgyUpdateManager.h>
#import "WXApi.h"

//智齿客服
#import <SobotKit/SobotKit.h>
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>
@property (nonatomic, strong) BXTabBarController * tabBarController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark ------QMUI环境设置-------
    [QMUIConfigurationTemplate setupConfigurationTemplate];
#pragma mark ------蒲公英SDK-------
    [self fzm_configPgy];
#pragma mark ------设置根控制器-------
    [self fzm_configRootVC];
#pragma mark ------配置全局键盘管理-------
    [self fzm_configIQKeyboardManager];
#pragma mark ------引导页配置-------
    [self fzm_configGuidePage];
#pragma mark ------配置腾讯bug分析-------
    [self fzm_configBugly];
#pragma mark ------友盟配置-------
    [self fzm_configYouMeng];
#pragma mark ------智齿客服配置-------
    [self setupSobotKit:application];
    return YES;
}

- (void)fzm_configPgy{
//    //启动基本SDK
//    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_AppId];
//    //启动更新检查SDK
//    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_AppId];
//    //关闭用户反馈
//    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
}

- (void)fzm_configRootVC{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController * VC = [UIViewController new];
    VC.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = VC;
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    WeakSelf
    //审核设置 开关没开 不返回不进入页面
    [[JJWInitApp sharedMethod]initApp:^(Version_App * app) {
        if (app.is_open.integerValue == 1 &&  ![JJWLogin sharedMethod].isLogin) {
            weakSelf.window.rootViewController = [LoginVC firstEnterAppOpenLoginCallback:^(BOOL compliont) {
                if (compliont) {
                    weakSelf.window.rootViewController = weakSelf.tabBarController;
                    if ([JJWLogin sharedMethod].isLogin) {
                        //验证手势
                        [weakSelf checkPassword:app.is_open.integerValue];
                    }
                }
            }];
        }else {
            weakSelf.window.rootViewController = weakSelf.tabBarController;
            [weakSelf checkPassword:app.is_open.integerValue];
        }
    }];
}
- (void)checkPassword:(BOOL)isOpen {
    BOOL hasPwd = [CLLockVC hasPwd];
    //验证手势密码
    if (hasPwd) {
        [CLLockVC showVerifyLockVCInVC:self.window.rootViewController forgetPwdBlock:^{
            NSLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [lockVC dismiss:0.0f];
            if (isOpen) {
                //开启弹幕
                [[ScrollLabelHelp shareInstance]showScrolle];
            }
        }];
    }else {
        if (isOpen) {
            //开启弹幕
            [[ScrollLabelHelp shareInstance]showScrolle];
        }
    }
}

- (void)fzm_configIQKeyboardManager{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enableAutoToolbar= NO;
    keyboardManager.shouldResignOnTouchOutside = YES;
}

-(BXTabBarController *)tabBarController{
    if (!_tabBarController) {
        _tabBarController = [[BXTabBarController alloc]init];
    }
    return _tabBarController;
}

- (void)fzm_configBugly {
    [Bugly startWithAppId:@"fa0e94eabc"];
}

- (void)fzm_configYouMeng{
    [CTShareTool setupShare];
}
//MARK: 微信代理方法
- (void)onResp:(BaseResp *)resp
{
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if(aresp.errCode== 0 && [aresp.state isEqualToString:@"123"])
    {
        NSString *code = aresp.code;
        NSLog(@"-----WeiXinCode<%@>",code);
        if ([CTShareTool shareDefault].authBlock) {
            [CTShareTool shareDefault].authBlock(code);
        }
        
    }
}
- (void)fzm_configGuidePage{
    
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:JJWImageFile(@"GuidePageOne", @"png")];
    [images addObject:JJWImageFile(@"GuidePageTwo", @"png")];
    [images addObject:JJWImageFile(@"GuidePageThree", @"png")];
    [images addObject:JJWImageFile(@"GuidePageFour", @"png")];
    
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:nil
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]];
}

//智齿客服
- (void)setupSobotKit:(UIApplication *)application {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10")) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert |UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (!error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [[UIApplication sharedApplication] registerForRemoteNotifications];
                    });
                }
            }];
        }else{
            [self registerPush:application];
        }
        // 获取APPKEY
        NSString *APPKEY = SobotKitAppKey;
        [[ZCLibClient getZCLibClient].libInitInfo setAppKey:APPKEY];
        
#ifdef DEBUG //开发环境
        [[ZCLibClient getZCLibClient] setIsDebugMode:YES];
#else //发布环境
        [[ZCLibClient getZCLibClient] setIsDebugMode:NO];
#endif
        [[ZCLibClient getZCLibClient]setAutoNotification:YES];
        [[ZCLibClient getZCLibClient]initZCIMCaht];
    });
}
-(void)registerPush:(UIApplication *)application{
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
    } else{ // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
}

//====================For iOS 10====================

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    //功能：可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionAlert);
    
}

//点击推送消息后回调
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"---Token--%@", deviceToken);
    [[ZCLibClient getZCLibClient] setToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    NSLog(@"userInfo == %@\n%@",userInfo,message);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Regist fail%@",error);
}





//分享回调
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
#warning 是否正在授权中  因为微信绑定code跟友盟的share冲突，造成微信授权返回的 code无法使用，在handleOpenUrl方法内部使用
    if ([CTShareTool shareDefault].isAuthing) {
        [CTShareTool shareDefault].isAuthing = NO;
        return [WXApi handleOpenURL:url delegate:self];
    }else {
        return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
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
