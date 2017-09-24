//
//  CashKeyBoradVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/20.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "CashKeyBoradVC.h"
#import "KeyBoradView.h"
#import "QRCodeVC.h"

@interface CashKeyBoradVC ()
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet KeyBoradView *keyBoradView;

@property (nonatomic,copy) NSString * amountStr;

@end

@implementation CashKeyBoradVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CommonBackgroudColor;
    self.cashBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cashBtn.layer.borderWidth = 1.f;
    switch (_payType) {
        case PayFaceToFaceType:
            self.title = @"当面付";
            break;
        case PayQuickType:
            self.title = @"快捷支付";
            break;
        case PayScanCodeType:
            self.title = @"扫码付";
            break;
        default:
            break;
    }
    __block typeof(_amountStr)weakAmount = _amountStr;
    self.keyBoradView.valueBlock = ^(NSString * s) {
        weakAmount = s;
    };
    WeakSelf
    self.keyBoradView.valueBlock = ^(NSString * str) {
        QRCodeVC * VC = [[QRCodeVC alloc]init];
        VC.amount = _amountStr;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
}











@end
