//
//  FZMMyAccounntWithdrawCell.m
//  JiuJiuWu
//
//  Created by 付志敏 on 2018/1/17.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "FZMMyAccounntWithdrawCell.h"

#import "FZMMyAccountWithdrawModel.h"

#import "NSDate+Category.h"

@implementation FZMMyAccounntWithdrawCell{
    
    __weak IBOutlet UILabel *_accountLabel;
    __weak IBOutlet UILabel *_amountLabel;
    __weak IBOutlet UILabel *_dateLabel;
    FZMMyAccountWithdrawModel *_model;
    __weak IBOutlet UILabel *_orderNumLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configParameter:(FZMMyAccountWithdrawModel *)model{
    _amountLabel.text = [NSString stringWithFormat:@"￥%.2f",model.amount];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.add_time.doubleValue];
    _dateLabel.text = [date toString];
    _accountLabel.text = model.account;
    _orderNumLabel.text = model.order_no;
}

@end
