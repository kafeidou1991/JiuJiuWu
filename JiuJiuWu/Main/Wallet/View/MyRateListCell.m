//
//  MyRateListCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/27.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "MyRateListCell.h"
#import "MyRateItem.h"

@implementation MyRateListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateCell:(MyRateItem *)item {
    self.rateNameLabel.text = item.channel_name;
    self.rateLabel.text = [NSString stringWithFormat:@"%@‰",item.scale];
    self.accountingDateLabel.text = item.in_account;
    self.limitAmontLabel.text = item.limit_amont;
    self.haveScoreLabel.text = item.have_score ? @"有" : @"无";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
