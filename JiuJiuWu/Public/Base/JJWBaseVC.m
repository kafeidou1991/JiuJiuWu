//
//  JJWBaseVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseVC.h"
#import "UIImage+Extension.h"
#import "MBProgressHUD.h"
#import "BXNavigationController.h"
#import "LoginVC.h"

//#import "LoginViewController.h"

@interface JJWBaseVC () {
    MBProgressHUD   *_mbProgressHud;
}

@end

@implementation JJWBaseVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isPush = YES;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _emptyView = self.emptyView;
    self.view.backgroundColor = [UIColor whiteColor];
    //兼容第三方键盘
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.leftBarButtonItem = BLACKBAR_BUTTON;
    [self performSelector:@selector(afterProFun) withObject:nil afterDelay:0.3];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(relogin) name:ReplaceLogin object:nil];
    
}
- (void)relogin {
    [LoginVC OpenLogin:self callback:^(BOOL compliont) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}



- (void)afterProFun{
    
}

#pragma mark - 版本控制
- (void)checkVersion{
    NSDictionary * dict = @{@"OS":@"2"};
    [JJWNetworkingTool PostWithUrl:CheckUpdate params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [self hudclose];
        Version_App * version = [Version_App yy_modelWithDictionary:responseObject];
        if (STRISEMPTY(version.version_code)) {
            return;
        }
        BOOL flag = [self needUpdateVersion:version.version_code];
        if (flag) {
            if (!_alarmMessage) {
                _alarmMessage = [[SUAlarmMessage alloc] init];
            }
            WeakSelf
            [_alarmMessage showAlarm:@"更新提示" msg:STRISEMPTY(version.content)?@"发现新版本":version.content cancelButtonTitle:@"取消" otherButtonTitle:@"更新" callBack:^(int buttonIndex) {
                if (buttonIndex == 1) {
                    [weakSelf toAppstore];
                    if ([version.is_force isEqualToString:@"1"]) {
                        exit(0);
                    }
                }else{
                    if ([version.is_force isEqualToString:@"1"]) {
                        exit(0);
                    }
                }
            }];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [self hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void)toAppstore{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_Address]];
    
}
//如果当前版本小于系统返回版本，则需要提示升级
-(BOOL)needUpdateVersion:(NSString *)nowVersion
{
    NSInteger clientV = [self toInteger:APP_VERSION];
    NSInteger systemV = [self toInteger:nowVersion];
    if (clientV < systemV) {
        return YES;
    }
    else {
        return NO;
    }
}
-(NSInteger)toInteger:(NSString *)str
{
    NSInteger result = 0;
    NSInteger versionLength = 4;//代表支持的最多分割位数
    NSMutableArray *strArray = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"."]];
    NSInteger count = strArray.count;
    for (int i = 0; i < versionLength - count; i++) {
        [strArray addObject:@"0"];
    }
    for (int i = 0; i < strArray.count; i++) {
        NSInteger num = [[strArray objectAtIndex:i] integerValue];
        num *= [self getNumber:strArray.count-i-1];
        result += num;
    }
    return result;
}

-(NSInteger)getNumber:(NSInteger)length
{
    NSInteger result = 1;
    for (int i = 0; i < length; i++) {
        result *= 10;
    }
    return result;
}


-(void) backAction:(id)sender{
    [self willBack];
    if(_isPush){
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)willBack{
    
}

- (void)hudShow:(UIView *)inView msg:(NSString *)msgText{
    if (_mbProgressHud == nil) {
        _mbProgressHud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    }
    _mbProgressHud.contentColor = [UIColor whiteColor];
    _mbProgressHud.bezelView.color = [UIColor blackColor];
    _mbProgressHud.label.text = msgText;
    _mbProgressHud.animationType = MBProgressHUDAnimationZoom;
    [_mbProgressHud showAnimated:YES];
}
- (void)hudclose{
    if (_mbProgressHud) {
        [_mbProgressHud removeFromSuperview];
        [_mbProgressHud hideAnimated:NO];
        _mbProgressHud = nil;
    }
}


- (void)dealloc{
    [[SDImageCache sharedImageCache] clearMemory];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}










@end
