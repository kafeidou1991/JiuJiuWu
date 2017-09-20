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

@end

@implementation PerfectInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView.layer.borderColor = themeColor.CGColor;
    self.backView.layer.borderWidth = 1.f;
    
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
