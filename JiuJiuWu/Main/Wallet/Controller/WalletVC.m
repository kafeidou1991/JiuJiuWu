//
//  WalletVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "WalletVC.h"

#import "LoginVC.h"

@interface WalletVC ()<UINavigationControllerDelegate>

@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)login {
    [LoginVC OpenLogin:self callback:^(BOOL compliont) {
        
    }];

}



//设置导航栏隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHome = [viewController isKindOfClass:[self class]];
    [navigationController setNavigationBarHidden:isHome animated:YES];
};






















@end
