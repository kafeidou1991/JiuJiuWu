//
//  ManageCardCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ManageCardCell.h"
#import "BankCardItem.h"
#import "UIButton+WebCache.h"

#if environment
static NSString * const baseImageUrl = @"http://www.jiujiuwu.cn/";
#else
static NSString * const baseImageUrl = @"http://test.jiujiuwu.cn/";
#endif

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
- (void)updateCell:(DloginData *)item {
    if (!STRISEMPTY(item.idcard_img_one)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.idcard_img_one];
        [self.oneBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        [self.oneBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.oneBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.idcard_img_two)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.idcard_img_two];
        [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.idcard_img_three)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.idcard_img_three];
        [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.shop_head_img)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.shop_head_img];
        [self.fourBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        [self.fourBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.fourBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.shop_inner_img)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.shop_inner_img];
        [self.fiveBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        [self.fiveBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.fiveBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.shop_cash_img)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.shop_cash_img];
        [self.sixBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        [self.sixBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.sixBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
}

@end
