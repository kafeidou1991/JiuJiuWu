//
//  ConfirmPayVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/25.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ConfirmPayVC.h"
#import "LevelItem.h"

@interface ConfirmPayVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UIButton *qrBtn;
- (IBAction)downQRAction:(UIButton *)sender;

@end

@implementation ConfirmPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.borderWidth = 1.f;
    self.qrBtn.layer.cornerRadius = 5.f;
    [self updateContent];
}
- (void)updateContent {
    self.titleLabel.text = [NSString stringWithFormat:@"升级%@",_item.level_name];
    self.rateLabel.text = [NSString stringWithFormat:@"（费率千分之%@）",_item.scale];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",_item.price];
}


- (IBAction)downQRAction:(UIButton *)sender {
}
@end
