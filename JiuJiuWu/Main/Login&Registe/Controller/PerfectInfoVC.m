//
//  ActiveCodeViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/28.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "PerfectInfoVC.h"

@interface PerfectInfoVC ()

@property (weak, nonatomic) IBOutlet UIView *backView;
- (IBAction)backAction:(UIButton *)sender;
- (IBAction)nowAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *cnacelBtn;
@property (weak, nonatomic) IBOutlet UIButton *nowBtn;
@property (weak, nonatomic) IBOutlet UIButton *knowBtn;

@end

@implementation PerfectInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView.layer.borderColor = themeColor.CGColor;
    self.backView.layer.borderWidth = 1.f;
    
    if (_type == PerfectNoCheckInfoType) {
        self.contentLabel.text = @"以便为您提供更好的服务请完善资料信息";
        self.cnacelBtn.hidden = NO;
        self.nowBtn.hidden = NO;
        self.knowBtn.hidden = YES;
    }else if (_type == PerfectCheckingInfoType) {
        self.contentLabel.text = @"您的资料正在审核中,请耐心等待";
        self.cnacelBtn.hidden = YES;
        self.nowBtn.hidden = YES;
        self.knowBtn.hidden = NO;
    }else if (_type == PerfectCheckFailedInfoType) {
        self.contentLabel.text = @"您的资料审核失败，请联系管理员！";
        self.cnacelBtn.hidden = YES;
        self.nowBtn.hidden = YES;
        self.knowBtn.hidden = NO;
    }
    
    
}



//以后再说
- (IBAction)backAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_cancelBlock) {
        _cancelBlock();
    }
}
//立即解决
- (IBAction)nowAction:(UIButton *)sender {
    if (_activeVlock) {
        _activeVlock();
    }
}

@end
