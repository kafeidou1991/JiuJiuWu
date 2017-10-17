//
//  TwoCreditInfoTableViewCell.m
//  YZF
//
//  Created by 张竟巍 on 2017/6/30.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "TwoCreditInfoTableViewCell.h"

@interface TwoCreditInfoTableViewCell ()


@end

@implementation TwoCreditInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftView.leftLabel.text = @"有效期";
    self.rightView.leftLabel.text = @"安全码";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
