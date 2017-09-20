//
//  JJWGlobal.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWGlobal.h"
#import "OpenUDID.h"
#import "UIViewController+MJPopupViewController.h"
#import "LoginVC.h"
#import "PerfectInfoVC.h"
#import "ManageCardVC.h"


@implementation JJWGlobal
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.uuid = [OpenUDID value];
        self.uuid = STRISEMPTY(self.uuid) ? @"" : self.uuid;
    }
    return self;
}
+(instancetype) sharedMethod
{
    static JJWGlobal *g_global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_global = [[JJWGlobal alloc] init];
    });
    return g_global;
}
@end

@interface JJWLogin (){
    PerfectInfoVC * _activeCodeVC;
}

@end

@implementation JJWLogin
+(instancetype) sharedMethod
{
    static JJWLogin *g_pub = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_pub = [[JJWLogin alloc] init];
    });
    return g_pub;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isLogin = NO;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dic = [userDefaults objectForKey:LOGIN_DATA_KEY];
        if (dic) {
            _loginData = [DloginData yy_modelWithDictionary:dic];
            if(_loginData){
                _isLogin = YES;
            }else{
                [self _setEmptyLoginData];
            }
        }
        
    }
    return self;
}
- (void)saveLoginData:(DloginData *)data{
    if(data){
        NSMutableDictionary *dic = [data yy_modelToJSONObject];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:dic forKey:LOGIN_DATA_KEY];
        [userDefaults synchronize];
        self.loginData = data;
        _isLogin = YES;
    }
}
- (void) _setEmptyLoginData{
    _loginData = [[DloginData alloc]init];
}

- (void)removeLoingData{
    _isLogin = NO;
    NSString * tempStr = self.loginData.mobile;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:LOGIN_DATA_KEY];
    [userDefaults synchronize];
    [self _setEmptyLoginData];
    //重新登录用
    self.loginData.mobile = tempStr;
}


#pragma mark - 检查资料是否齐全

- (BOOL)checkInfo:(JJWBaseVC *)viewController complete:(void (^)())block{
    __block __weak typeof(viewController)weakVC = viewController;
    _loginData.status = @"2";
    if (STRISEMPTY(_loginData.status)) {
        //吊起登录页面
        [LoginVC OpenLogin:viewController callback:nil];
        return NO;
    }
    //资料齐全正常
    if (_loginData.status.integerValue == 1) {
        DLog(@"资料齐全！");
        if (block) {
            block();
        }
        return YES;
    }
    if (_loginData.status.integerValue == 2) {
        //需要验证
        _activeCodeVC = [[PerfectInfoVC alloc]init];
        _activeCodeVC.cancelBlock = ^{
            [weakVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        };
        //激活完成
        _activeCodeVC.activeVlock = ^{
            ManageCardVC * VC = [[ManageCardVC alloc]init];
            VC.type = BindRegisterCardType;
            [weakVC.navigationController pushViewController:VC animated:YES];
            [weakVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        };
        [viewController presentPopupViewController:_activeCodeVC animationType:MJPopupViewAnimationFade];
        return NO;
    }
//    if (_loginData.member.status.integerValue == 3) {
//        if (STRISEMPTY(_loginData.merchant.openType)) {
//            PerfectInfoViewController * pushVC = [[PerfectInfoViewController alloc]init];
//            [viewController.navigationController pushViewController:pushVC animated:YES];
//        }else{
//            ShopInfoViewController * vc = [[ShopInfoViewController alloc]init];
//            [viewController.navigationController pushViewController:vc animated:YES];
//        }
//        return NO;
//    }
//    if (_loginData.member.status.integerValue == 4) {
//        ClearingViewController * pushVC = [[ClearingViewController alloc]init];
//        [viewController.navigationController pushViewController:pushVC animated:YES];
//        return NO;
//    }
    return YES;
}



@end

