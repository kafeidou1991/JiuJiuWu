//
//  CompanyInfoCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/21.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "CompanyInfoCell.h"
#import "BankCardItem.h"
#import "UIButton+WebCache.h"

#if environment
static NSString * const baseImageUrl = @"http://www.jiujiuwu.cn/";
#else
static NSString * const baseImageUrl = @"http://test.jiujiuwu.cn/";
#endif

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
- (void)updateCell:(DloginData *)item ImageBlock:(void (^)(UIButton *,UIImage *))block {
    if (!STRISEMPTY(item.license_img)) {
        NSString * str = [baseImageUrl stringByAppendingString:item.license_img];
        [self.cardPhotoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (block) {
                block(self.cardPhotoBtn,image);
            }
        }];
        [self.cardPhotoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateHighlighted];
        [self.cardPhotoBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateSelected];
    }
}

@end
