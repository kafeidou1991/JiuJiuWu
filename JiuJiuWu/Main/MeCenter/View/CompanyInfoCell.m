//
//  CompanyInfoCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/21.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "CompanyInfoCell.h"
#import "BankCardItem.h"

@interface CompanyInfoCell ()
@property (weak, nonatomic) IBOutlet UIButton *cardPhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopInfoBtn;
- (IBAction)clickAction:(UIButton *)sender;


@end

@implementation CompanyInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickAction:(UIButton *)sender {
    if (_block) {
        _block(sender);
    }
}
-(void)updateCell:(BankCardItem *)item {
    if (item.license_img.size.width != 0) {
        [self.cardPhotoBtn setImage:item.license_img forState:UIControlStateNormal];
        [self.cardPhotoBtn setImage:item.license_img forState:UIControlStateHighlighted];
        [self.cardPhotoBtn setImage:item.license_img forState:UIControlStateSelected];
    }
    if (item.shop_head_img.size.width != 0) {
        [self.shopInfoBtn setImage:item.shop_head_img forState:UIControlStateNormal];
        [self.shopInfoBtn setImage:item.shop_head_img forState:UIControlStateHighlighted];
        [self.shopInfoBtn setImage:item.shop_head_img forState:UIControlStateSelected];
    }
}

@end
