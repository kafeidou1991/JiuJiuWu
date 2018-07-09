//
//  PubilcBankCardCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/22.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "PubilcBankCardCell.h"

@interface PubilcBankCardCell()

- (IBAction)selectClick:(UIButton *)sender;


@end

@implementation PubilcBankCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)updateBindCardCell:(NSDictionary *)dict textAlignment:(NSTextAlignment)align{
    self.inputTextField.textAlignment = align;
    self.titleLabel.text = dict[@"title"];
    self.inputTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dict[@"placeholder"] attributes:@{NSForegroundColorAttributeName :UIColorRGB(51, 51, 51),NSFontAttributeName :[UIFont systemFontOfSize:14]}];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)selectClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.inputTextField.enabled = sender.selected;
    if (_block) {
        _block(sender);
    }
}
@end
