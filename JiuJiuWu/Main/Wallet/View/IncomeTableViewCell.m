//
//  IncomeTableViewCell.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/26.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "IncomeTableViewCell.h"
#import "NSDate+Category.h"

@interface IncomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amoutLabelCenterY;

@end

@implementation IncomeTableViewCell
- (void)updateCell:(PaySuccessItem *)item{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:item.add_time.doubleValue];
    self.timeLabel.text = [date toString];
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",item.order_no];
//    [NSString stringWithFormat:@"￥%@",item.amount.length > 8 ? [item.amount substringToIndex:8] : item.amount]
    self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f",item.amount.doubleValue/100];
//    支付渠道00：微信，01：支付宝，02：百付宝，03翼支付，04：qq钱包
    self.typeLabel.text = [self _configType:item.channel_flag];
    
}
-(void)updateBorrowCell:(PaySuccessItem *)item{
    self.timeLabel.text = @"2017-06-08";
    self.orderLabel.text =@"欠款已还完";
    self.amountLabel.text = @"￥2.00";
    self.typeLabel.hidden =YES;
}

- (void)updateWithdrawListCell:(PaySuccessItem *)item{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:item.add_time.doubleValue];
    self.timeLabel.text = [date toString];
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",item.order_no];
    self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f",item.amount.doubleValue/100];
    //    支付渠道00：微信，01：支付宝，02：百付宝，03翼支付，04：qq钱包
//    self.typeLabel.text = [self _configType:item.channel_flag];
}
- (NSString *) _configType:(NSString *)type{
    NSString * temp = @"";
    if (STRISEMPTY(type)) {
        return @"";
    }
    switch (type.integerValue) {
        case 0:
            temp = @"微信支付";
            break;
        case 1:
            temp = @"支付宝支付";
            break;
        case 2:
//            temp = @"百付宝";
            break;
        case 3:
//            temp = @"翼支付";
            break;
        case 4:
//            temp = @"QQ钱包";
            break;
        case 5:
            temp = @"快捷支付";
            break;
            
        default:
            break;
    }
    return temp;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
