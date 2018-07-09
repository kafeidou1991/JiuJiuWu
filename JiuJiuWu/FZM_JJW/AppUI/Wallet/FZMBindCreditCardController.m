//
//  FZMBindCreditCardController.m
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/11.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "FZMBindCreditCardController.h"

#import "FZMMyCreditCardModel.h"

@interface FZMBindCreditCardController ()<QMUITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConsH;
@property (weak, nonatomic) IBOutlet UITextField *creditCardNumTF;
@property (weak, nonatomic) IBOutlet QMUITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTF;
@property (weak, nonatomic) IBOutlet UITextField *accountNameTF;
@property (weak, nonatomic) IBOutlet QMUITextField *securityCodeTF;
@property (weak, nonatomic) IBOutlet QMUITextField *validityDateTF;

@property (strong, nonatomic) FZMMyCreditCardModel *model;

@end


@implementation FZMBindCreditCardController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"绑定信用卡";
    
    [self.creditCardNumTF becomeFirstResponder];
    
    _phoneNumTF.maximumTextLength = 11;
    _securityCodeTF.maximumTextLength = 3;
    _validityDateTF.maximumTextLength = 4;
    
    _phoneNumTF.delegate = self;
    _securityCodeTF.delegate = self;
    _validityDateTF.delegate = self;
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.contentViewConsH.constant = self.lastView.qmui_bottom + kJJWDefaultMargin;
}


- (IBAction)bandCreditCardAction:(QMUIFillButton *)sender {
    
    if (kJJWStringIsEmpty(self.creditCardNumTF.text)) {
        [JJWCommonHelper fzm_shakeView:self.creditCardNumTF];
        
        return;
    }
    
    if (kJJWStringIsEmpty(self.phoneNumTF.text)) {
        [JJWCommonHelper fzm_shakeView:self.phoneNumTF];
        
        return;
    }
    
    if (kJJWStringIsEmpty(self.accountNameTF.text)) {
        [JJWCommonHelper fzm_shakeView:self.accountNameTF];
        
        return;
    }
    
    if (kJJWStringIsEmpty(self.securityCodeTF.text)) {
        [JJWCommonHelper fzm_shakeView:self.securityCodeTF];
        
        return;
    }
    
    if (kJJWStringIsEmpty(self.validityDateTF.text)) {
        [JJWCommonHelper fzm_shakeView:self.validityDateTF];
        
        return;
    }
    
    if (kJJWStringIsEmpty(self.bankNameTF.text)) {
        [JJWCommonHelper fzm_shakeView:self.bankNameTF];
        
        return;
    }
    
    [self bandNetworking];
}

- (void)bandNetworking{
    [QMUITips showLoading:STTR_ater_on inView:self.view];
    
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,
                            @"account_no":self.creditCardNumTF.text,
                            @"mobile":self.phoneNumTF.text,
                            @"account_name":self.accountNameTF.text,
                            @"cvn2":self.securityCodeTF.text,
                            @"validity_time":self.validityDateTF.text,
                            @"bank_name":self.bankNameTF.text};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:BindCreditCard params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [QMUITips hideAllToastInView:weakSelf.view animated:YES];
        _model = [FZMMyCreditCardModel yy_modelWithJSON:responseObject];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        if (_refeshCreditCardListBlok) {
            _refeshCreditCardListBlok();
        }
        
    } failed:^(NSError *error, id chaceResponseObject) {
        [QMUITips hideAllToastInView:weakSelf.view animated:YES];
        [JJWBase alertMessage:[error localizedDescription] cb:nil];
    }];

}

#pragma mark - <QMUITextFieldDelegate>
- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    
    if ([textField isEqual:_phoneNumTF]) {
        [FZMTipsHelper showWithText:[NSString stringWithFormat:@"手机号不能超过 %@ 个字符", @(textField.maximumTextLength)]  inView:self.view];
    } else if ([textField isEqual:_securityCodeTF]) {
        [FZMTipsHelper showWithText:[NSString stringWithFormat:@"安全码不能超过 %@ 个字符", @(textField.maximumTextLength)]  inView:self.view];
    } else if([textField isEqual:_validityDateTF]){
        [FZMTipsHelper showWithText:[NSString stringWithFormat:@"有效日期不能超过 %@ 个字符", @(textField.maximumTextLength)]  inView:self.view];
    }
    
}

@end
