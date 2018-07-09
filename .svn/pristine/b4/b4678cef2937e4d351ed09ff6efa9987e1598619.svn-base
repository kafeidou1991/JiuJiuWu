//
//  MyShareBenefitCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/5.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "MyShareBenefitCell.h"

@interface MyShareBenefitCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation MyShareBenefitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithdrawListCell:(MyShareBenefitItem *)item{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:item.add_time.doubleValue];
    self.timeLabel.text = [date toString:@"yyyy-MM-dd HH:mm:ss"];
    self.orderLabel.text = [NSString stringWithFormat:@"%@",item.order_no];
    self.buyLabel.text = item.buy_name;
    self.memberLabel.text = item.member_name;
    self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f",item.amount.floatValue];
}

@end
