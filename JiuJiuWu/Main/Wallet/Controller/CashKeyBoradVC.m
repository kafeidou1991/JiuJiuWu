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
#import "IncomeListVC.h"

@interface CashKeyBoradVC ()
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet KeyBoradView *keyBoradView;

@end

@implementation CashKeyBoradVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CommonBackgroudColor;
    self.navigationItem.rightBarButtonItem = [JJWBase createCustomBarButtonItem:self action:@selector(listAction) title:@"收款记录"];
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
    WeakSelf
    self.keyBoradView.valueBlock = ^(NSString * str) {
        if (str.doubleValue > 0) {
            QRCodeVC * VC = [[QRCodeVC alloc]init];
            VC.amount = str;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }else {
            [JJWBase alertMessage:@"请输入指定金额" cb:nil];
        }
    };
}

-(void)listAction {
    //收款记录
    IncomeListVC * VC = [[IncomeListVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}










@end
