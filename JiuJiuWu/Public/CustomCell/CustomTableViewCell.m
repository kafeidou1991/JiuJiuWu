//
//  CustomTableViewCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/13.
//  Copyright © 2017年 张竟巍. All rights reserved.
//  //左文字 右边输入框样式

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateRegistCell:(NSDictionary *)dict {
    self.titleLabel.text = dict[@"title"];
    self.inputTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dict[@"placeholder"] attributes:@{NSForegroundColorAttributeName :UIColorRGB(82, 82, 82),NSFontAttributeName :[UIFont systemFontOfSize:14]}];
}













@end
