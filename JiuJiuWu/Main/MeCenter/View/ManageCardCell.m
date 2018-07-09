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
- (void)updateCell:(DloginData *)item ImageBlock:(void (^)(UIButton *,UIImage *))block {
    if (!STRISEMPTY(item.idcard_img_one)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.idcard_img_one];
        [self.oneBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (block) {
                block(self.oneBtn,image);
            }
        }];
        [self.oneBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.oneBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.idcard_img_two)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.idcard_img_two];
        [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (block) {
                block(self.twoBtn,image);
            }
        }];
        [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.twoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
    if (!STRISEMPTY(item.idcard_img_three)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.idcard_img_three];
        [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (block) {
                block(self.threeBtn,image);
            }
        }];
        [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.threeBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
//    if (!STRISEMPTY(item.shop_head_img)) {
//        NSString * str = [baseImageUrl stringByAppendingString:item.shop_head_img];
//        [self.fourBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (block) {
//                block(self.fourBtn,image);
//            }
//        }];
//        [self.fourBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
//        [self.fourBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
//    }
//    if (!STRISEMPTY(item.shop_inner_img)) {
//        NSString * str = [baseImageUrl stringByAppendingString:item.shop_inner_img];
//        [self.fiveBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (block) {
//                block(self.fiveBtn,image);
//            }
//        }];
//        [self.fiveBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
//        [self.fiveBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
//    }
//    if (!STRISEMPTY(item.shop_cash_img)) {
//        NSString * str = [baseImageUrl stringByAppendingString:item.shop_cash_img];
//        [self.sixBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (block) {
//                block(self.sixBtn,image);
//            }
//        }];
//        [self.sixBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
//        [self.sixBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
//    }
//    if (!STRISEMPTY(item.contract_img_one)) {
//        NSString * str = [baseImageUrl stringByAppendingString:item.contract_img_one];
//        [self.sevenBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (block) {
//                block(self.sevenBtn,image);
//            }
//        }];
//        [self.sevenBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
//        [self.sevenBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
//    }
//    if (!STRISEMPTY(item.contract_img_two)) {
//        NSString * str = [baseImageUrl stringByAppendingString:item.contract_img_two];
//        [self.eightBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (block) {
//                block(self.eightBtn,image);
//            }
//        }];
//        [self.eightBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
//        [self.eightBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
//    }
}

@end
