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
//#import "LoginViewController.h"


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



@end

