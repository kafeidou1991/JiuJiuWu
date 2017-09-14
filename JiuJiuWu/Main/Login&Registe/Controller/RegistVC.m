//
//  RegistVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/13.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "RegistVC.h"
#import "RegistExtendVC.h"

@interface RegistVC ()<UITextFieldDelegate> {
    //计时器
    NSInteger seconds;
    NSTimer *captchaTimer;//计时器
}
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

- (IBAction)sendCodeAction:(UIButton *)sender;
- (IBAction)nextAction:(UIButton *)sender;
- (IBAction)protocolAction:(UIButton *)sender;
- (IBAction)clickProtocolAction:(UIButton *)sender;


@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"账号注册";
    //改变协议按钮的渲染颜色
    [self changeProtocolImage];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self validateCodeControl:@"获取验证码"];
}


#pragma mark -发送验证码
- (IBAction)sendCodeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString * account = [self.mobileTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![account checkPhoneNumInput]) {
        [JJWBase alertMessage:@"请输入正确的手机号！" cb:nil];
        return;
    }
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"mobile":account};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:RegistGetCode params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [weakSelf openTimer];
        [JJWBase alertMessage:@"验证码已发送" cb:nil];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [weakSelf validateCodeControl:@"重新发送"];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
#pragma mark -下一步
- (IBAction)nextAction:(UIButton *)sender {
    if (!self.protocolBtn.selected) {
        [JJWBase alertMessage:@"请先选择同意协议！" cb:nil];
        return;
    }
    [self.view endEditing:YES];
    NSString * account = [self.mobileTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * code = [self.codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![account checkPhoneNumInput]) {
        [JJWBase alertMessage:@"请输入正确的手机号！" cb:nil];
        return;
    }
    if (STRISEMPTY(code)) {
        [JJWBase alertMessage:@"请输入验证码！" cb:nil];
        return;
    }
    //验证验证码
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"mobile":account,@"code":code};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:CheckRegistCode params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        
        RegistExtendVC * VC = [[RegistExtendVC alloc]init];
        VC.mobile = account;
        [self.navigationController pushViewController:VC animated:YES];
        
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
#pragma mark -点击协议
- (IBAction)protocolAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}
//跳转H5
- (IBAction)clickProtocolAction:(UIButton *)sender {
    
}

- (void)changeProtocolImage {
    UIImage * image = [[UIImage imageNamed:@"regista_protocol_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.protocolBtn setImage:image forState:UIControlStateHighlighted];
    [self.protocolBtn setImage:image forState:UIControlStateSelected];
    self.protocolBtn.tintColor = themeColor;
}


#pragma mark -计时器
- (void)openTimer {
    seconds = 60;
    self.sendCodeBtn.userInteractionEnabled = NO;
    [captchaTimer invalidate];
    captchaTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(retransmissiontimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:captchaTimer forMode:NSDefaultRunLoopMode];
    [captchaTimer fire];
}
- (void)retransmissiontimer:(NSTimer *)timer
{
    seconds--;
    if (seconds == 0){
        [self validateCodeControl:@"重新发送"];
    }else{
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)seconds] forState:UIControlStateNormal];
    }
}
- (void)validateCodeControl:(NSString*)title {
    [captchaTimer invalidate];
    [self.sendCodeBtn setTitle:title forState:UIControlStateNormal];
    self.sendCodeBtn.userInteractionEnabled = YES;
}

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
        if (beString.length > 6) {
            return NO;
        }
    }
    return YES;
}

















@end
