//
//  WithdrawViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "WithdrawVC.h"
#import "SUMessageTextView.h"

@interface WithdrawVC ()
@property (weak, nonatomic) IBOutlet SUMessageTextView *amoutTextField;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UILabel *canOutLabel;
- (IBAction)outAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;

@end

@implementation WithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = CommonBackgroudColor;
    [self _configInfo];
}
- (void) _configInfo{
    self.amoutTextField.placeHolderFont = [UIFont systemFontOfSize:14];
    self.amoutTextField.placeHolder = @"\n请输入提现金额";
    self.amoutTextField.font = [UIFont systemFontOfSize:40];
    self.amoutTextField.keyboardType = UIKeyboardTypeDecimalPad;
    NSString *  temp = [JJWLogin sharedMethod].loginData.account;
    self.canOutLabel.text = [NSString stringWithFormat:@"可提用额度%.2f",self.userMoney.doubleValue];
    if (temp.length > 3) {
        self.cardLabel.text = [NSString stringWithFormat:@"%@（%@）",[JJWLogin sharedMethod].loginData.bank_name,[temp substringFromIndex:temp.length - 4]];
    }
}

- (IBAction)outAction:(UIButton *)sender {
    if (STRISEMPTY(self.amoutTextField.text)) {
        [JJWBase alertMessage:@"请输入具体金额" cb:nil];
        return;
    }
    if (self.amoutTextField.text.floatValue > self.userMoney.floatValue) {
        [JJWBase alertMessage:@"已超过最大提现金额!" cb:nil];
        return;
    }
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,
                            @"amount":self.amoutTextField.text};
    [JJWNetworkingTool PostOriginalWithUrl:Withdrawal params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"提现成功!" cb:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WithdrawSuccess" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
    
    
}
@end
