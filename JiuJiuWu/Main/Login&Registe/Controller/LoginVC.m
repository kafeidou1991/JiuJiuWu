//
//  LoginVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/13.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "LoginVC.h"
#import "BXNavigationController.h"
#import "RegistVC.h"
#import "CTShareTool.h"
#import "ScrollLabelHelp.h"

@interface LoginVC ()<UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;

- (IBAction)loginAction:(UIButton *)sender;

- (IBAction)registAction:(UIButton *)sender;

- (IBAction)closeAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeTopLayout;

@property (nonatomic, assign)BOOL isFirst;  //首次进入App 需要登录

@end

@implementation LoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.registBtn.layer.borderColor = JJWThemeColor.CGColor;
    self.registBtn.layer.borderWidth = 1.f;
    self.topSpace.constant = IS_IPHONE5 ? 32.f : 64.f;
    self.closeTopLayout.constant = STATUS_BAR_HEIGHT;
    if (self.isFirst) {
        self.closeBtn.hidden = YES;
    }else {
        self.closeBtn.hidden = NO;
        [self.closeBtn setImage:[[UIImage imageNamed:@"closePage"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.closeBtn setImage:[[UIImage imageNamed:@"closePage"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
        [self.closeBtn setImage:[[UIImage imageNamed:@"closePage"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    }
    NSString * mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginMobileKey"];
    if (!STRISEMPTY(mobile)) {
        self.mobileTextField.text = mobile;
    }
}
#pragma mark - 登录
- (IBAction)loginAction:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString * account = [self.mobileTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * seccort = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![account checkPhoneNumInput]) {
        [JJWBase alertMessage:@"请输入正确的手机号！" cb:nil];
        return;
    }
    if (STRISEMPTY(seccort)) {
        [JJWBase alertMessage:@"请输入密码！" cb:nil];
        return;
    }
    if (seccort.length < 6) {
        [JJWBase alertMessage:@"密码至少6位！" cb:nil];
        return;
    }
    [self hudShow:self.view msg:STTR_ater_on];
//    TPSHOP
    NSDictionary * dict = @{@"username":account,@"password":[NSString md5Digest:[NSString stringWithFormat:@"%@",seccort]].lowercaseString,@"push_id":@"",@"unique_id":[JJWGlobal sharedMethod].uuid};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:UserLogin params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        //登录成功
        DloginData * data = [DloginData yy_modelWithDictionary:responseObject];
        if (weakSelf.isFirst) {
            //首次登录需要进行微信授权
            if (STRISEMPTY(data.union_user_id)) {
                [[CTShareTool shareDefault]getAuthWithUserInfoFromWechatVC:self Auth:^(NSString * code) {
                    [weakSelf  bindWeChatUnionId:code Data:data];
                }];
            }else {
                [weakSelf loginSuccess:data];
            }
        }else {
            [weakSelf loginSuccess:data];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void)loginSuccess:(DloginData *)data {
    [[JJWLogin sharedMethod]saveLoginData:data];
    [self backAction:nil];
    if (self.loginCompletion) {
        self.loginCompletion(YES);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kLoginSuccess object:nil];
    [[NSUserDefaults standardUserDefaults]setObject:data.mobile forKey:@"loginMobileKey"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //登录成功显示弹幕
    [[ScrollLabelHelp shareInstance]showScrolle];
}
- (void)bindWeChatUnionId:(NSString *)unionId Data:(DloginData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (STRISEMPTY(unionId)) {
            return;
        }
        [self hudShow:self.view msg:STTR_ater_on];
        NSDictionary * dict = @{@"token":data.token,@"code":unionId};
        WeakSelf
        [JJWNetworkingTool PostWithUrl:SaveUnion params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf hudclose];
            //绑定微信unicon 成功
            [weakSelf loginSuccess:data];
        } failed:^(NSError *error, id chaceResponseObject) {
            [weakSelf hudclose];
            [JJWBase alertMessage:error.domain cb:nil];
        }];
    });
}
#pragma mark - 注册
- (IBAction)registAction:(UIButton *)sender {
    RegistVC * regist = [[RegistVC alloc]init];
    regist.type = RegistAccountType;
    [self.navigationController pushViewController:regist animated:YES];
}

- (IBAction)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//吊起登录
+(void) OpenLogin:(UIViewController *)viewController callback:(CBLoginCompletion) loginComplation {
    LoginVC *loginv = [[LoginVC alloc] init];
    if (loginComplation) {
        loginv.loginCompletion = loginComplation;
    }
    loginv.isPush = NO;
    BXNavigationController *nav = [[BXNavigationController alloc]initWithRootViewController:loginv];;
    nav.edgesForExtendedLayout = UIRectEdgeNone;
    [viewController presentViewController:nav animated:YES completion:nil];
}
+(BXNavigationController *)firstEnterAppOpenLoginCallback:(CBLoginCompletion)loginComplation {
    LoginVC *loginv = [[LoginVC alloc] init];
    if (loginComplation) {
        loginv.loginCompletion = loginComplation;
    }
    loginv.isPush = NO;
    loginv.isFirst = YES;
    loginv.closeBtn.hidden = YES;
    BXNavigationController *nav = [[BXNavigationController alloc]initWithRootViewController:loginv];
    nav.edgesForExtendedLayout = UIRectEdgeNone;
    return nav;
}

//设置导航栏隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHome = [viewController isKindOfClass:[self class]];
    [navigationController setNavigationBarHidden:isHome animated:YES];
};

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * beString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 100) {
        if (beString.length > 11) {
            return NO;
        }
    }
    if (textField.tag == 101) {
        if (beString.length > 15) {
            return NO;
        }
    }
    return YES;
}




@end
