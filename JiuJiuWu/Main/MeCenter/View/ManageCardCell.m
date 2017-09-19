//
//  ManageCardCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ManageCardCell.h"
#import "BankCardItem.h"

@implementation ManageCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cameraAction:(UIButton *)sender {
    if (_block) {
        _block(sender);
    }
}
- (void)updateCell:(BankCardItem *)item {
    if (item.idcard_img_one.size.width != 0) {
        [self.oneBtn setImage:item.idcard_img_one forState:UIControlStateNormal];
        [self.oneBtn setImage:item.idcard_img_one forState:UIControlStateHighlighted];
        [self.oneBtn setImage:item.idcard_img_one forState:UIControlStateSelected];
    }else if (item.idcard_img_two.size.width != 0) {
        [self.twoBtn setImage:item.idcard_img_two forState:UIControlStateNormal];
        [self.twoBtn setImage:item.idcard_img_two forState:UIControlStateHighlighted];
        [self.twoBtn setImage:item.idcard_img_two forState:UIControlStateSelected];
    }else if (item.idcard_img_three.size.width != 0) {
        [self.threeBtn setImage:item.idcard_img_three forState:UIControlStateNormal];
        [self.threeBtn setImage:item.idcard_img_three forState:UIControlStateHighlighted];
        [self.threeBtn setImage:item.idcard_img_three forState:UIControlStateSelected];
    }
}

@end
