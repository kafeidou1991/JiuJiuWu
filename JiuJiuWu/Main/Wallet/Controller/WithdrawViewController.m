//
//  WithdrawViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "WithdrawViewController.h"
#import "SUMessageTextView.h"

@interface WithdrawViewController ()
@property (weak, nonatomic) IBOutlet SUMessageTextView *amoutTextField;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UILabel *canOutLabel;
- (IBAction)outAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = CommonBackgroudColor;
//    [self.outBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self _configInfo];
}
-(void)afterProFun{
    //请求接口 余额
    [self hudShow:self.view msg:STTR_ater_on];
    WeakSelf
//    NSDictionary * dict = @{@"token":[YZFLogin sharedMethod].loginData.token};
//    [YZFNetworkingTool PostWithUrl:UserStaus params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        CheckItem * item = [CheckItem yy_modelWithDictionary:responseObject];
//        NSString * money = item.money;
//        DloginData * loginData = [YZFLogin sharedMethod].loginData;
//        loginData.member.money = money;
//        [[YZFLogin sharedMethod]saveLoginData:loginData];
//        [weakSelf hudclose];
//        weakSelf.canOutLabel.text = [NSString stringWithFormat:@"可提用额度%.02f",money.floatValue];
//    } failed:^(NSError *error, id chaceResponseObject) {
//        [weakSelf hudclose];
//        [YZFBase alertMessage:error.domain cb:nil];
//    }];
    
}

- (void) _configInfo{
//    self.amoutTextField.placeHolderFont = [UIFont systemFontOfSize:14];
//    self.amoutTextField.placeHolder = @"\n请输入提现金额";
//    self.amoutTextField.font = [UIFont systemFontOfSize:40];
//    self.amoutTextField.keyboardType = UIKeyboardTypeDecimalPad;
//    NSString *  temp = [YZFLogin sharedMethod].loginData.merchant.account;
//    if (_info) {
//        self.canOutLabel.text = [NSString stringWithFormat:@"可提用额度%.01g",_info.notExtractProfit.floatValue];
//    }
//    if (temp.length > 3) {
//        self.cardLabel.text = [NSString stringWithFormat:@"中国农业银行（%@）",[temp substringFromIndex:temp.length - 4]];
//    }
}

- (IBAction)outAction:(UIButton *)sender {
//    if (STRISEMPTY(self.amoutTextField.text)) {
//        [YZFBase alertMessage:@"请输入具体金额" cb:nil];
//        return;
//    }
//    if (_info) {
//        if (self.amoutTextField.text.floatValue > _info.notExtractProfit.floatValue) {
//            [YZFBase alertMessage:@"已超过最大提现金额!" cb:nil];
//            return;
//        }
//    }else{
//        if (self.amoutTextField.text.floatValue > [YZFLogin sharedMethod].loginData.member.money.floatValue) {
//            [YZFBase alertMessage:@"已超过最大提现金额!" cb:nil];
//            return;
//        }
//    }
//    WeakSelf
//    [self hudShow:self.view msg:STTR_ater_on];
//    NSDictionary * dict = @{@"token":[YZFLogin sharedMethod].loginData.token,
//                            @"amount":self.amoutTextField.text};
//    [YZFNetworkingTool PostWithUrl:Withdrawals_API params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
//        [weakSelf hudclose];
//        [YZFBase alertMessage:@"提现成功!" cb:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"WithdrawSuccess" object:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    } failed:^(NSError *error, id chaceResponseObject) {
//        [weakSelf hudclose];
//        [YZFBase alertMessage:error.domain cb:nil];
//    }];
    
    
}
@end
