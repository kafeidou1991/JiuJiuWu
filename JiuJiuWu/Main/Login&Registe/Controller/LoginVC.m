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

@interface LoginVC ()<UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;

- (IBAction)loginAction:(UIButton *)sender;

- (IBAction)registAction:(UIButton *)sender;

@end

@implementation LoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.registBtn.layer.borderColor = themeColor.CGColor;
    self.registBtn.layer.borderWidth = 1.f;
    self.topSpace.constant = IS_IPHONE5 ? 32.f : 64.f;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!STRISEMPTY([JJWLogin sharedMethod].loginData.mobile)) {
        self.mobileTextField.text = [JJWLogin sharedMethod].loginData.mobile;
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
    NSDictionary * dict = @{@"username":account,@"password":[NSString md5Digest:[NSString stringWithFormat:@"TPSHOP%@",seccort]].lowercaseString,@"push_id":@"",@"unique_id":[JJWGlobal sharedMethod].uuid};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:UserLogin params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        //登录成功
        DloginData * data = [DloginData yy_modelWithDictionary:responseObject];
        [[JJWLogin sharedMethod]saveLoginData:data];
        [self backAction:nil];
        if (self.loginCompletion) {
            self.loginCompletion(YES);
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
#pragma mark - 注册
- (IBAction)registAction:(UIButton *)sender {
    RegistVC * regist = [[RegistVC alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
