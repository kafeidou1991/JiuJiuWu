//
//  FZMWalletCreditCardCell.m
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/11.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "FZMWalletCreditCardCell.h"
#import "FZMMyCreditCardModel.h"

@implementation FZMWalletCreditCardCell{
    
    __weak IBOutlet UIView *_backView;
    __weak IBOutlet UILabel *_accountNameLabel;
    __weak IBOutlet UILabel *_validDateLabel;
    __weak IBOutlet UILabel *_cretidCardNumLabel;
    __weak IBOutlet UILabel *_bankNameLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    JJWViewBorderRadius(_backView, kJJWSmallMargin)
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configParameter:(FZMMyCreditCardModel *)model{
    _validDateLabel.text = kJJWStringIsEmpty(model.validity_time) ? kJJWLabel_NoData : model.validity_time;
    _cretidCardNumLabel.text = kJJWStringIsEmpty(model.account_no) ? kJJWLabel_NoData : model.account_no;
    _bankNameLabel.text = kJJWStringIsEmpty(model.bank_name) ? kJJWLabel_NoData : model.bank_name;
    _accountNameLabel.text = kJJWStringIsEmpty(model.account_name) ? kJJWLabel_NoData : model.account_name;
}

@end
